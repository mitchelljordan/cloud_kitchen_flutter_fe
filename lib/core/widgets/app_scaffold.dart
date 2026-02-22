import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  int _getIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location.startsWith('/recipe')) return 1;
    if (location.startsWith('/profile')) return 2;
    if (location.startsWith('/settings')) return 3;

    return 0; // home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/recipe');
        break;
      case 2:
        context.go('/profile');
        break;
      case 3:
        context.go('/settings');
        break;
    }
  }

  // NEW: Dynamic AppBar title based on route
  String _getTitle(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    // on navbar
    if (location.startsWith('/recipe')) return 'Recipe';
    if (location.startsWith('/profile')) return 'Profile';
    if (location.startsWith('/settings')) return 'Settings';

    // not on navbar
    if (location.startsWith('/scan')) return 'Scan';
    if (location.startsWith('/pantry')) return 'Pantry';

    return 'Cloud Kitchen'; // Home
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getIndex(context);

    return Scaffold(
      appBar: AppBar(title: Text(_getTitle(context))),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => _onTap(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu),
            selectedIcon: Icon(Icons.menu),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
