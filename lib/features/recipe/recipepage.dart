import 'package:flutter/material.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({super.key, required this.title});

  final String title;

  @override
  State<RecipePage> createState() => _MyRecipePageState();
}

class _MyRecipePageState extends State<RecipePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Favorite Recipes pressed');
                },
                child: const Text(
                  'Favorite Recipes',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('Search Recipes pressed');
                },
                child: const Text(
                  'Search Recipes',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}