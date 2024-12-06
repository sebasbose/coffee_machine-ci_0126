import 'package:coffee_machine_frontend/models/order.dart';
import 'package:coffee_machine_frontend/models/payment.dart';
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
  int totalCost = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchCoffees();
  }

  // Fetch coffees from the backend
  Future<void> fetchCoffees() async {
    setState(() {
      isLoading = true;
    });

    try {
      final result = await _coffeeService.fetchCoffees();
      setState(() {
        coffees = result;
        order.clear();
        totalCost = 0;
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
  if (order.isEmpty || totalCost == 0) {
    showError("Order cannot be empty.");
    return;
  }

  final currentOrder = Order(items: order);
  final payment = Payment(
    totalAmount: totalCost,
    coins: [], // Ajusta según las monedas disponibles
    bills: [],
  );

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


  // Show error dialog
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

  // Show success dialog
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
                      totalCost = order.entries
                          .map((e) => coffees
                              .firstWhere((c) => c.name == e.key)
                              .price *
                              e.value)
                          .fold(0, (sum, price) => sum + price);
                    });
                  },
                );
              },
            ),
      bottomNavigationBar: OrderSummary(
        totalAmount: totalCost,
        onPlaceOrder: placeOrder,
      ),
    );
  }
}
