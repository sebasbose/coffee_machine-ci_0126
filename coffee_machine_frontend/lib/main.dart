import 'package:coffee_machine_frontend/views/home_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CoffeeMachine());
}

class CoffeeMachine extends StatelessWidget {
  const CoffeeMachine({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(title: 'Flutter Demo Home Page'),
    );
  }
}