import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_kitchen_flutter_fe/features/auth/data/authservice.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 8),

              const Text('Settings:', style: TextStyle(fontSize: 24)),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    final authService = AuthService();

                    await authService.logout();

                    if (!context.mounted) return;

                    context.go('/loginpage');
                  },
                  child: const Text('Logout', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
