import 'package:flutter/material.dart';
import '../models/coffee.dart';

class CoffeeTile extends StatelessWidget {
  final Coffee coffee;
  final int selectedQuantity;
  final void Function(int) onQuantityChanged;

  const CoffeeTile({
    Key? key,
    required this.coffee,
    required this.selectedQuantity,
    required this.onQuantityChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(coffee.name),
      subtitle: Text('Stock: ${coffee.stock} | Precio: ₡${coffee.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: selectedQuantity > 0
                ? () => onQuantityChanged(selectedQuantity - 1)
                : null,
          ),
          Text('$selectedQuantity'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: selectedQuantity < coffee.stock
                ? () => onQuantityChanged(selectedQuantity + 1)
                : null,
          ),
        ],
      ),
    );
  }
}
