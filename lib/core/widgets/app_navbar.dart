import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const List<NavigationDestination> appNavDestinations = [
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
];

int getNavBarIndex(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();
  if (location.startsWith('/recipe')) return 1;
  if (location.startsWith('/profile')) return 2;
  if (location.startsWith('/settings')) return 3;
  return 0; // home
}

void onNavBarTap(BuildContext context, int index) {
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
