import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

String getAppBarTitle(BuildContext context) {
  final location = GoRouterState.of(context).uri.toString();

  if (location.startsWith('/recipe')) return 'Recipe';
  if (location.startsWith('/profile')) return 'Profile';
  if (location.startsWith('/settings')) return 'Settings';

  if (location.startsWith('/scan')) return 'Scan';
  if (location.startsWith('/pantry')) return 'Pantry';

  return 'Cloud Kitchen';
}
