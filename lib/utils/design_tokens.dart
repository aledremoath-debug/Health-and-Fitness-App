import 'package:flutter/material.dart';

/// Centralized Design System Tokens for Vitality AI
/// Ensures consistency and WCAG 2.1 AA compliance across screens.
class AppTokens {
  // ============================
  // COLORS
  // ============================
  // Core Palettes
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color primaryBlueLight = Color(0xFF2563EB); // better contrast for light Theme
  static const Color accentIndigo = Color(0xFF4F46E5);
  static const Color emerald = Color(0xFF10B981);
  static const Color orange = Color(0xFFF59E0B);
  static const Color cyan = Color(0xFF06B6D4);
  static const Color red = Color(0xFFEF4444);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF050508);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);

  // Light Theme Colors
  static const Color lightBackground = Color(0xFFF3F4F6);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);

  // ============================
  // SPACING (8pt grid system)
  // ============================
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;

  // ============================
  // BORDER RADIUS
  // ============================
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius24 = 24.0;
  static const double radius32 = 32.0;
  static const double radiusMax = 999.0;
  
  static final BorderRadius borderRadius16 = BorderRadius.circular(radius16);
  static final BorderRadius borderRadius24 = BorderRadius.circular(radius24);
  static final BorderRadius borderRadius32 = BorderRadius.circular(radius32);

  // ============================
  // TYPOGRAPHY (Inter)
  // ============================
  static const String fontFamily = 'Inter';
  
  static const double fontH1 = 36.0; // Hero Headers
  static const double fontH2 = 28.0; // Section Headers
  static const double fontH3 = 22.0; // Card Titles
  static const double fontBodyLarge = 16.0; // Large Body
  static const double fontBody = 14.0; // Normal Body
  static const double fontBodySmall = 12.0; // Modals/Captions
  static const double fontCaption = 10.0; // Tiny Labels
  
  // ============================
  // ACCESSIBILITY / TOUCH TARGETS
  // ============================
  /// WCAG 2.1 AA minimum touch target size
  static const double minTouchTarget = 44.0;

  // ============================
  // ANIMATIONS
  // ============================
  static const Duration animFast = Duration(milliseconds: 150);
  static const Duration animNormal = Duration(milliseconds: 250);
  static const Duration animSlow = Duration(milliseconds: 350);

  // ============================
  // SHADOWS
  // ============================
  static List<BoxShadow> shadowLight = [
    BoxShadow(
      // ignore: deprecated_member_use_from_same_package
      color: Colors.black.withOpacity(0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> shadowDark = [
    BoxShadow(
      // ignore: deprecated_member_use_from_same_package
      color: Colors.black.withOpacity(0.2),
      blurRadius: 15,
      offset: const Offset(0, 8),
    ),
  ];
}
