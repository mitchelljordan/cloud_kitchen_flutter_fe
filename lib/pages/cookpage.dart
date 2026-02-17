import 'package:flutter/material.dart';

class CookPage extends StatefulWidget {
  const CookPage({super.key, required this.title});

  final String title;

  @override
  State<CookPage> createState() => _MyCookPageState();
}

class _MyCookPageState extends State<CookPage> {
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