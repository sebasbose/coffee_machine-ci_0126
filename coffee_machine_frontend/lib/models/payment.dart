class Payment {
  int totalAmount;
  int selectedAmount = 0;
  List<int> coins;
  List<int> bills;

  Payment({
    required this.totalAmount,
    required this.coins,
    required this.bills
  });

  Map<String, dynamic> toJson() {
    return {
      'totalAmount': selectedAmount,
      'coins': coins,
      'bills': bills,
    };
  }
}