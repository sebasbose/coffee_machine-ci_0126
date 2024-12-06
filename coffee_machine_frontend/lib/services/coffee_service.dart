import 'dart:convert';
import 'package:coffee_machine_frontend/constants.dart';
import 'package:coffee_machine_frontend/models/order.dart';
import 'package:http/http.dart' as http;
import '../models/coffee.dart';
import '../models/payment.dart';
import '../models/change.dart';

class CoffeeService {
  final String baseUrl = backend_url;

  Future<List<Coffee>> fetchCoffees() async {
    final url = Uri.parse('$baseUrl/AvailableCoffees');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Coffee.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargas el inventario: ${response.statusCode}');
    }
  }

  Future<String> placeOrder(Order order, Payment payment) async {
    final url = Uri.parse('$baseUrl/Purchase');
    final payload = jsonEncode({
      ...order.toJson(),
      'payment': payment.toJson(),
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: payload,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      final errorMessage =
        response.body.isNotEmpty ? response.body : 'Error al realizar orden.';
      throw Exception(errorMessage);
    }
  }
}
