class Change {
  final int amount;
  final Map<int, int> coinBreakdown;

  Change({
    required this.amount,
    required this.coinBreakdown,
  });

  factory Change.fromJson(Map<String, dynamic> json) {
    return Change(
      amount: json['amount'], 
      coinBreakdown: Map<int, int>.from(json['coinBreakdown'])
    );
  }
}