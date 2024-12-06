import 'package:coffee_machine_frontend/models/order.dart';
import 'package:coffee_machine_frontend/models/payment.dart';
import 'package:coffee_machine_frontend/widgets/payment_dialog.dart';
import 'package:flutter/material.dart';
import '../models/coffee.dart';
import '../services/coffee_service.dart';
import '../widgets/coffee_tile.dart';
import '../widgets/order_summary.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CoffeeService _coffeeService = CoffeeService();
  List<Coffee> coffees = [];
  Map<String, int> order = {};
  Payment payment = Payment(totalAmount: 0, coins: [], bills: []);
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCoffees();
  }

  Future<void> fetchCoffees() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _coffeeService.fetchCoffees();
      setState(() {
        coffees = result;
        order.clear();
        payment = Payment(totalAmount: 0, coins: [], bills: []);
      });
    } catch (e) {
      showError("Error obteniendo inventario de cafe: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> placeOrder() async {
    if (order.isEmpty || this.payment.totalAmount == 0) {
      showError("La orden no puede ser procesada.");
      return;
    }

    if (this.payment.coins.isEmpty || this.payment.bills.isEmpty) {
      showError("Debes seleccionar como pagar.");
      return;
    }

    final currentOrder = Order(items: order);
    final payment = this.payment;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await _coffeeService.placeOrder(currentOrder, payment);
      showSuccess(result);
      fetchCoffees();
    } catch (e) {
      showError("Error al realizar orden: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showError(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Success"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void showPaymentDialog() {
  showDialog(
    context: context,
    builder: (ctx) => PaymentDialog(
      totalAmount: payment.totalAmount,
      onPaymentSelected: (coins, bills, selectedAmount) {
        payment.coins = coins;
        payment.bills = bills;
        payment.selectedAmount = selectedAmount;
        placeOrder();
      },
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Coffee Machine')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: coffees.length,
              itemBuilder: (context, index) {
                final coffee = coffees[index];
                return CoffeeTile(
                  coffee: coffee,
                  selectedQuantity: order[coffee.name] ?? 0,
                  onQuantityChanged: (quantity) {
                    setState(() {
                      order[coffee.name] = quantity;
                      payment.totalAmount = order.entries
                          .map((e) =>
                              coffees.firstWhere((c) => c.name == e.key).price *
                              e.value)
                          .fold(0, (sum, price) => sum + price);
                    });
                  },
                );
              },
            ),
      bottomNavigationBar: OrderSummary(
        totalAmount: payment.totalAmount,
        onPlaceOrder: showPaymentDialog,
      ),
    );
  }
}
