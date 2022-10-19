import 'package:expense_tracker/config/constants.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get _baseTheme => ThemeData(
    primaryColor: AppColors.kPrimary,
    scaffoldBackgroundColor: AppColors.kScaffold,
    fontFamily: Fonts.kPrimary,
    colorScheme: const ColorScheme.dark(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.kPrimary, elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.kDark,
      selectedItemColor: AppColors.kScaffold,
      unselectedItemColor: AppColors.kGrey,
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    iconTheme: IconThemeData(
      color: AppColors.kGrey,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.kPrimary,
    ),
  );

  static ThemeData get defaultTheme =>
      _baseTheme.copyWith(brightness: Brightness.light);
}
