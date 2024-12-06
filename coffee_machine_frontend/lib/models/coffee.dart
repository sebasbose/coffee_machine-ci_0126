class Coffee {
  final String name;
  final int stock;
  final int price;

  Coffee({
    required this.name,
    required this.stock,
    required this.price
  });

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      name: json['name'], 
      stock: json['stock'], 
      price: json['price']
    );
  }
}