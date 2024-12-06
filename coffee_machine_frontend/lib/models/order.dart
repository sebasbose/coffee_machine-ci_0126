class Order {
  final Map<String, int> items;

  Order({required this.items});

  Map<String, dynamic> toJson() {
    return {
      'order': items,
    };
  }
}
