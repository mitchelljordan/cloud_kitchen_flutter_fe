import 'package:flutter/material.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
