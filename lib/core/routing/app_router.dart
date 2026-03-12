//import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_kitchen_flutter_fe/features/home/homepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/scan/scanpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/pantry/pantrypage.dart';
import 'package:cloud_kitchen_flutter_fe/features/recipe/recipepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/profile/profilepage.dart';
import 'package:cloud_kitchen_flutter_fe/features/settings/settingspage.dart';
import 'package:cloud_kitchen_flutter_fe/core/widgets/app_scaffold.dart';
import 'package:cloud_kitchen_flutter_fe/features/login/loginpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/scan/camera/scanproductpage.dart';
import 'package:cloud_kitchen_flutter_fe/features/register/registerpage.dart';
import 'package:cloud_kitchen_flutter_fe/core/services/token_storage.dart';
import 'package:cloud_kitchen_flutter_fe/features/scan/addpantryitem/addpantryitempage.dart';

/* 
// Description: This is where all navagtion for the  page is defined.
// Navigation rules for go_router:A
// context.__() = navigate to a page is how you will call nav from UI
// push() = add page (shows back button)
// go()   = replace stack (no back button)
// pop()  = go back
// Rule: If user should return → push(). If not → go().
//   
 */

final GoRouter appRouter = GoRouter(
  initialLocation: '/',

  redirect: (context, state) async {
    final token = await TokenStorage.getToken();

    final loggingIn =
        state.matchedLocation == '/loginpage' ||
        state.matchedLocation == '/register';

    // If not logged in, send to login
    if (token == null && !loggingIn) {
      return '/loginpage';
    }

    // If already logged in, prevent going back to login/register
    if (token != null && loggingIn) {
      return '/';
    }

    return null;
  },

  routes: [
    GoRoute(path: '/loginpage', builder: (context, state) => const LoginPage()),

    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),

    GoRoute(
      path: '/ScanProduct',
      builder: (context, state) => const ScanProductPage(),
    ),

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

        GoRoute(
          path: '/addpantryitem',
          builder: (context, state) => const AddPantryItemPage(),
        ),
      ],
    ),
  ],
);
