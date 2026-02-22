import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightBlue,
      brightness: Brightness.dark,
    ),

    appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),

    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: Colors.lightBlue.withOpacity(0.25),
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        textStyle: const TextStyle(
          fontSize: 20, // 40 is extremely large for most layouts
        ),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    ),
  );
}
