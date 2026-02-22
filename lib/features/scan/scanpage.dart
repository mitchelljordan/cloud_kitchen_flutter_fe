import 'package:flutter/material.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

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
                debugPrint('Product Scan pressed');
              },
              child: const Text('Scan Product', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Scan Receipt pressed');
              },
              child: const Text('Scan Receipt', style: TextStyle(fontSize: 24)),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Custom Product pressed');
              },
              child: const Text(
                'Custom Product',
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
