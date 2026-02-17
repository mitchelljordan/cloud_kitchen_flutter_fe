import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_kitchen_flutter_fe/pages/homepage.dart';
import 'package:cloud_kitchen_flutter_fe/pages/scanpage.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(title: 'Cloud Kitchen'),
    ),
    GoRoute(
      path: '/scan',
      name: 'scan',
      builder: (context, state) => const ScanPage(title: 'Scan'),
    ),
    GoRoute(
      path: '/pantry',
      name: 'pantry',
      builder: (context, state) => const HomePage(title: 'Pantry'),
    ),
    GoRoute(
      path: '/nutrition',
      name: 'nutrition',
      builder: (context, state) => const HomePage(title: 'Nutrition'),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Text('No route defined for ${state.uri.toString()}'),
    ),
  ),
);
