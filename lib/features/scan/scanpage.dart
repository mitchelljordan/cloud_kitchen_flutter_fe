import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
                context.push('/ScanProduct');
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
                context.push('/createproduct');
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
