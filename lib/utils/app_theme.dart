import 'package:flutter/material.dart';
import 'design_tokens.dart';

class AppTheme {
  // Backwards compatibility legacy colors
  static const Color primaryBlue = AppTokens.primaryBlue;
  static const Color accentIndigo = AppTokens.accentIndigo;
  static const Color emerald = AppTokens.emerald;
  static const Color orange = AppTokens.orange;
  static const Color cyan = AppTokens.cyan;
  static const Color amber = AppTokens.orange;
  static const Color red = AppTokens.red;

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppTokens.darkBackground,
      primaryColor: AppTokens.primaryBlue,
      colorScheme: const ColorScheme.dark(
        primary: AppTokens.primaryBlue,
        secondary: AppTokens.accentIndigo,
        surface: AppTokens.darkSurface,
        onSurface: AppTokens.darkTextPrimary,
        onPrimary: Colors.white,
      ),
      fontFamily: AppTokens.fontFamily,
      cardTheme: CardThemeData(
        // ignore: deprecated_member_use_from_same_package
        color: AppTokens.darkSurface.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: AppTokens.borderRadius32,
          // ignore: deprecated_member_use_from_same_package
          side: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        elevation: 0,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        // ignore: deprecated_member_use_from_same_package
        fillColor: Colors.white.withOpacity(0.05),
        border: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          // ignore: deprecated_member_use_from_same_package
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          // ignore: deprecated_member_use_from_same_package
          borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          borderSide: const BorderSide(color: AppTokens.primaryBlue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space20, 
          vertical: AppTokens.space16
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          // ignore: deprecated_member_use_from_same_package
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: AppTokens.borderRadius16,
            // ignore: deprecated_member_use_from_same_package
            borderSide: BorderSide(color: Colors.white.withOpacity(0.05)),
          ),
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppTokens.lightBackground,
      primaryColor: AppTokens.primaryBlueLight,
      colorScheme: const ColorScheme.light(
        primary: AppTokens.primaryBlueLight,
        secondary: AppTokens.accentIndigo,
        surface: AppTokens.lightSurface,
        onSurface: AppTokens.lightTextPrimary,
        onPrimary: Colors.white,
      ),
      fontFamily: AppTokens.fontFamily,
      cardTheme: CardThemeData(
        // ignore: deprecated_member_use_from_same_package
        color: Colors.white.withOpacity(0.9),
        shape: RoundedRectangleBorder(
          borderRadius: AppTokens.borderRadius32,
          // ignore: deprecated_member_use_from_same_package
          side: BorderSide(color: Colors.black.withOpacity(0.05)),
        ),
        elevation: 2,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppTokens.borderRadius16,
          borderSide: const BorderSide(color: AppTokens.primaryBlueLight, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppTokens.space20, 
          vertical: AppTokens.space16
        ),
      ),
    );
  }
}
