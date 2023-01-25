import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Colors.white,height: 1.25),
    headlineSmall: TextStyle(color: Colors.black,height: 1.25),
    titleSmall: TextStyle(color: Colors.white,height: 1.25),
    titleMedium: TextStyle(color: Colors.white,height: 1.25),
    titleLarge: TextStyle(color: Colors.white,height: 1.25),
    labelMedium: TextStyle(color: Colors.white,height: 1.25),
    labelSmall: TextStyle(color: Colors.white,height: 1.25),
    labelLarge: TextStyle(color: Colors.white,height: 1.25),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    foregroundColor: Colors.black,
    backgroundColor: Colors.grey[100]
  ),
  scaffoldBackgroundColor: Colors.grey[100],
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black.withOpacity(0.04),
    selectedItemColor: Colors.orange.shade900,
    unselectedItemColor: Colors.white,
    elevation: 0,
  ),
);

ThemeData darkTheme =  ThemeData(
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Colors.black,height: 1.25),
    headlineSmall: TextStyle(color: Colors.white,height: 1.25),
    titleSmall: TextStyle(color: Colors.white,height: 1.25),
    titleMedium: TextStyle(color: Colors.black,height: 1.25),
    titleLarge: TextStyle(color: Colors.white,height: 1.25),
    labelMedium: TextStyle(color: Colors.black,height: 1.25),
    labelSmall: TextStyle(color: Colors.black,height: 1.25),
    labelLarge: TextStyle(color: Colors.black,height: 1.25),
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    foregroundColor: Colors.white,
    backgroundColor: Colors.black
  ),
  scaffoldBackgroundColor: Colors.black.withOpacity(0.5),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.black.withOpacity(0.04),
    selectedItemColor: Colors.orange.shade900,
    unselectedItemColor: Colors.black.withOpacity(0.8),
    elevation: 0,
  ),
);