import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.go('/recipe'),
              child: const Text('Recipe', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.go('/scan'),
              child: const Text('Scan', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () => context.go('/pantry'),
              child: const Text('Pantry', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
