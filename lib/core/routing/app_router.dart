import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_kitchen_flutter_fe/features/home/homepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/scan/scanpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/pantry/pantrypage.dart';
import 'package:cloud_kitchen_flutter_fe/features/nutrition/nutritionpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/recipe/recipepage.dart';

/* 
// Description: This is where all navagtion for the  page is defined.
// Navigation rules for go_router:
// context.__() = navigate to a page is how you will call nav from UI
// push() = add page (shows back button)
// go()   = replace stack (no back button)
// pop()  = go back
// Rule: If user should return → push(). If not → go().
//   
 */

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
      path: '/recipe',
      name: 'recipe',
      builder: (context, state) => const RecipePage(title: 'Recipe'),
    ),
    GoRoute(
      path: '/pantry',
      name: 'pantry',
      builder: (context, state) => const PantryPage(title: 'Pantry'),
    ),
    GoRoute(
      path: '/nutrition',
      name: 'nutrition',
      builder: (context, state) => const NutritionPage(title: 'Nutrition'),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Page Not Found')),
    body: Center(
      child: Text('No route defined for ${state.uri.toString()}'),
    ),
  ),
);
