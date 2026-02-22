//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_kitchen_flutter_fe/features/home/homepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/scan/scanpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/pantry/pantrypage.dart';
import 'package:cloud_kitchen_flutter_fe/features/recipe/recipepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/profile/profilepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/settings/settingspage.dart';
import 'package:cloud_kitchen_flutter_fe/core/widgets/app_scaffold.dart';

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
    ShellRoute(
      builder: (context, state, child) {
        return AppScaffold(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),

        GoRoute(path: '/scan', builder: (context, state) => const ScanPage()),

        GoRoute(
          path: '/pantry',
          builder: (context, state) => const PantryPage(),
        ),

        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfilePage(),
        ),

        GoRoute(
          path: '/recipe',
          builder: (context, state) => const RecipePage(),
        ),

        GoRoute(
          path: '/settings',
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
