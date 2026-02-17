import 'package:flutter/material.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key, required this.title});
  final String title;
  @override
  State<PantryPage> createState() => _MyPantryPageState();
}

class _MyPantryPageState extends State<PantryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Text('Pantry Page'),
      ),
    );
  }
}