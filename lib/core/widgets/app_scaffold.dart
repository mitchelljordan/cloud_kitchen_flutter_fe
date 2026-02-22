import 'package:flutter/material.dart';
import 'app_titles.dart';
import 'app_navbar.dart';

class AppScaffold extends StatelessWidget {
  final Widget child;

  const AppScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final selectedIndex = getNavBarIndex(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(getAppBarTitle(context)),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) => onNavBarTap(context, index),
        destinations: appNavDestinations,
      ),
    );
  }
}
