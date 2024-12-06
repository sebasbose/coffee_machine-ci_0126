class Payment {
  final int totalAmount;
  final List<int> coins;
  final List<int> bills;

  Payment({
    required this.totalAmount,
    required this.coins,
    required this.bills
  });

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': totalAmount,
      'coins': coins,
      'bills': bills,
    };
  }
}