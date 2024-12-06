import 'package:flutter/material.dart';

class OrderSummary extends StatelessWidget {
  final int totalAmount;
  final VoidCallback onPlaceOrder;

  const OrderSummary({
    Key? key,
    required this.totalAmount,
    required this.onPlaceOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: totalAmount > 0 ? onPlaceOrder : null,
        child: Text('Realizar Orden - Total: ₡$totalAmount'),
      ),
    );
  }
}
