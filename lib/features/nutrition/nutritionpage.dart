import 'package:flutter/material.dart';

class NutritionPage extends StatefulWidget {
  const NutritionPage({super.key, required this.title});
  final String title;
  @override
  State<NutritionPage> createState() => _MyNutritionPageState();
}

class _MyNutritionPageState extends State<NutritionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Nutrition Page'),
      ),
    );
  }
}