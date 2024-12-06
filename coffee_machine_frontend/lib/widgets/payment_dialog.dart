import 'package:flutter/material.dart';

class PaymentDialog extends StatefulWidget {
  final int totalAmount;
  final void Function(List<int>, List<int>, int) onPaymentSelected;

  const PaymentDialog({
    Key? key,
    required this.totalAmount,
    required this.onPaymentSelected,
  }) : super(key: key);

  @override
  _PaymentDialogState createState() => _PaymentDialogState();
}

class _PaymentDialogState extends State<PaymentDialog> {
  final Map<int, int> coinOptions = {500: 0, 100: 0, 50: 0, 25: 0};
    final Map<int, int> billOptions = {1000: 0};
  bool useBill = false;

  int getTotalPayment() {
    final coinTotal = coinOptions.entries
        .map((entry) => entry.key * entry.value)
        .fold(0, (sum, amount) => sum + amount);
    final billTotal = billOptions.entries
        .map((entry) => entry.key * entry.value)
        .fold(0, (sum, amount) => sum + amount);
    return coinTotal + billTotal;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Cantidad seleccionada: ₡${getTotalPayment()}"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...coinOptions.entries.map((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("₡${entry.key} colones"),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (coinOptions[entry.key]! > 0) {
                          setState(() {
                            coinOptions[entry.key] = coinOptions[entry.key]! - 1;
                          });
                        }
                      },
                    ),
                    Text("${entry.value}"),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          coinOptions[entry.key] = coinOptions[entry.key]! + 1;
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
          const Divider(),
          ...billOptions.entries.map((entry) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Billete ₡${entry.key} colones"),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (billOptions[entry.key]! > 0) {
                          setState(() {
                            billOptions[entry.key] = billOptions[entry.key]! - 1;
                          });
                        }
                      },
                    ),
                    Text("${entry.value}"),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          billOptions[entry.key] = billOptions[entry.key]! + 1;
                        });
                      },
                    ),
                  ],
                ),
              ],
            );
          }).toList(),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: widget.totalAmount <= getTotalPayment() ? () {
            final selectedCoins = coinOptions.entries
                .expand((entry) => List.generate(entry.value, (_) => entry.key))
                .toList();
            final selectedBills = billOptions.entries
                .expand((entry) => List.generate(entry.value, (_) => entry.key))
                .toList();
            widget.onPaymentSelected(selectedCoins, selectedBills, getTotalPayment());
            Navigator.of(context).pop();
          } : null,
          child: Text("Pagar (₡${widget.totalAmount} colones)"),
        ),
      ],
    );
  }
}
