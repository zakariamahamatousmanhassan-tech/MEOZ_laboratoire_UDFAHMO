import 'package:flutter/material.dart';

const Color emerald = Color(0xFF0B6E4F);
const Color gold = Color(0xFFC9A227);
const Color ivory = Color(0xFFFFFFFF);

final ThemeData meozTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: emerald,
    primary: emerald,
    secondary: gold,
    surface: ivory,
  ),
  scaffoldBackgroundColor: ivory,
  appBarTheme: const AppBarTheme(
    backgroundColor: emerald,
    foregroundColor: Colors.white,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: emerald,
      foregroundColor: Colors.white,
    ),
  ),
  cardTheme: CardThemeData(
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: gold, width: 1.2),
    ),
  ),
);
