import 'package:flutter/material.dart';

/// ============================================================
/// VitalityAI Design System - Complete Token Definitions
/// Version: 1.0.0
/// Last Updated: 2026-04-02
/// ============================================================
/// 
/// This file contains all design tokens for the VitalityAI app.
/// Following 8pt grid system and WCAG 2.1 AA compliance.
/// 
/// TABLE OF CONTENTS:
/// 1. Color Palette
/// 2. Typography
/// 3. Spacing
/// 4. Border Radius
/// 5. Shadows
/// 6. Animation
/// 7. Breakpoints
/// 8. Accessibility
/// 9. Component Tokens
/// ============================================================

class DesignSystem {
  // ============================
  // 1. COLOR PALETTE
  // ============================
  
  /// Primary Colors
  static const Color primary500 = Color(0xFF3B82F6);  // Main brand blue
  static const Color primary600 = Color(0xFF2563EB);  // Darker for emphasis
  static const Color primary400 = Color(0xFF60A5FA);  // Lighter variant
  static const Color primary100 = Color(0xFFDBEAFE);  // Background tint
  
  /// Accent/Secondary Colors
  static const Color accentIndigo = Color(0xFF4F46E5);
  static const Color accentPurple = Color(0xFF7C3AED);
  
  /// Semantic Colors
  static const Color success = Color(0xFF10B981);     // Emerald - positive
  static const Color warning = Color(0xFFF59E0B);     // Amber - caution
  static const Color error = Color(0xFFEF4444);       // Red - error
  static const Color info = Color(0xFF06B6D4);        // Cyan - info
  
  /// Neutral Colors - Dark Theme
  static const Color darkBg = Color(0xFF050508);
  static const Color darkSurface = Color(0xFF0F172A);
  static const Color darkSurfaceElevated = Color(0xFF1E293B);
  static const Color darkBorder = Color(0x1AFFFFFF);  // 10% white
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextTertiary = Color(0xFF64748B);
  
  /// Neutral Colors - Light Theme  
  static const Color lightBg = Color(0xFFF3F4F6);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightSurfaceElevated = Color(0xFFF9FAFB);
  static const Color lightBorder = Color(0x1A000000); // 10% black
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextTertiary = Color(0xFF94A3B8);
  
  /// Gradient Presets
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primary500, accentIndigo],
  );
  
  static const LinearGradient surfaceGradientDark = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [darkSurfaceElevated, darkBg],
  );
  
  static const LinearGradient surfaceGradientLight = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightSurface, lightBg],
  );
  
  // ============================
  // 2. TYPOGRAPHY
  // ============================
  
  /// Font Family
  static const String fontFamily = 'Inter';
  static const String fontFamilyFallback = 'SF Pro Display, -apple-system, BlinkMacSystemFont, sans-serif';
  
  /// Font Sizes (following 4px base unit)
  static const double textXs = 10.0;    // Caption
  static const double textSm = 12.0;    // Small
  static const double textBase = 14.0;  // Body
  static const double textLg = 16.0;    // Large Body
  static const double textXl = 18.0;    // Heading 4
  static const double text2xl = 20.0;   // Heading 3
  static const double text3xl = 22.0;   // Heading 2
  static const double text4xl = 28.0;   // Heading 1
  static const double text5xl = 36.0;   // Hero
  
  /// Font Weights
  static const FontWeight fontRegular = FontWeight.w400;
  static const FontWeight fontMedium = FontWeight.w500;
  static const FontWeight fontSemibold = FontWeight.w600;
  static const FontWeight fontBold = FontWeight.w700;
  static const FontWeight fontExtrabold = FontWeight.w900;
  
  /// Line Heights
  static const double lineHeightTight = 1.25;
  static const double lineHeightNormal = 1.5;
  static const double lineHeightRelaxed = 1.75;
  
  /// Letter Spacing
  static const double letterSpacingTight = -0.5;
  static const double letterSpacingNormal = 0.0;
  static const double letterSpacingWide = 0.5;
  static const double letterSpacingXWide = 1.0;
  
  /// Text Styles Presets
  static TextStyle heroText(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: text5xl,
    fontWeight: fontExtrabold,
    letterSpacing: letterSpacingTight,
    height: lineHeightTight,
    color: isDark ? darkTextPrimary : lightTextPrimary,
  );
  
  static TextStyle h1Text(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: text4xl,
    fontWeight: fontExtrabold,
    letterSpacing: letterSpacingTight,
    height: lineHeightTight,
    color: isDark ? darkTextPrimary : lightTextPrimary,
  );
  
  static TextStyle h2Text(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: text3xl,
    fontWeight: fontBold,
    letterSpacing: letterSpacingNormal,
    height: lineHeightNormal,
    color: isDark ? darkTextPrimary : lightTextPrimary,
  );
  
  static TextStyle h3Text(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: text2xl,
    fontWeight: fontBold,
    letterSpacing: letterSpacingNormal,
    height: lineHeightNormal,
    color: isDark ? darkTextPrimary : lightTextPrimary,
  );
  
  static TextStyle bodyText(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: textBase,
    fontWeight: fontMedium,
    letterSpacing: letterSpacingNormal,
    height: lineHeightNormal,
    color: isDark ? darkTextPrimary : lightTextPrimary,
  );
  
  static TextStyle bodySmallText(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: textSm,
    fontWeight: fontMedium,
    letterSpacing: letterSpacingNormal,
    height: lineHeightNormal,
    color: isDark ? darkTextSecondary : lightTextSecondary,
  );
  
  static TextStyle captionText(bool isDark) => TextStyle(
    fontFamily: fontFamily,
    fontSize: textXs,
    fontWeight: fontBold,
    letterSpacing: letterSpacingWide,
    height: lineHeightNormal,
    color: isDark ? darkTextTertiary : lightTextTertiary,
  );
  
  // ============================
  // 3. SPACING (8pt Grid)
  // ============================
  
  static const double space0 = 0;
  static const double space1 = 4.0;
  static const double space2 = 8.0;
  static const double space3 = 12.0;
  static const double space4 = 16.0;
  static const double space5 = 20.0;
  static const double space6 = 24.0;
  static const double space7 = 28.0;
  static const double space8 = 32.0;
  static const double space10 = 40.0;
  static const double space12 = 48.0;
  static const double space16 = 64.0;
  static const double space20 = 80.0;
  
  /// Edge Insets
  static const EdgeInsets paddingXs = EdgeInsets.all(space1);
  static const EdgeInsets paddingSm = EdgeInsets.all(space2);
  static const EdgeInsets paddingMd = EdgeInsets.all(space4);
  static const EdgeInsets paddingLg = EdgeInsets.all(space6);
  static const EdgeInsets paddingXl = EdgeInsets.all(space8);
  
  static const EdgeInsets paddingHorizontal = EdgeInsets.symmetric(horizontal: space4);
  static const EdgeInsets paddingVertical = EdgeInsets.symmetric(vertical: space4);
  
  // ============================
  // 4. BORDER RADIUS
  // ============================
  
  static const double radiusNone = 0;
  static const double radiusSm = 8.0;
  static const double radiusMd = 12.0;
  static const double radiusLg = 16.0;
  static const double radiusXl = 20.0;
  static const double radius2xl = 24.0;
  static const double radius3xl = 32.0;
  static const double radiusFull = 999.0;
  
  static final BorderRadius borderRadiusSm = BorderRadius.circular(radiusSm);
  static final BorderRadius borderRadiusMd = BorderRadius.circular(radiusMd);
  static final BorderRadius borderRadiusLg = BorderRadius.circular(radiusLg);
  static final BorderRadius borderRadiusXl = BorderRadius.circular(radiusXl);
  static final BorderRadius borderRadius2xl = BorderRadius.circular(radius2xl);
  static final BorderRadius borderRadius3xl = BorderRadius.circular(radius3xl);
  static final BorderRadius borderRadiusFull = BorderRadius.circular(radiusFull);
  
  // ============================
  // 5. SHADOWS
  // ============================
  
  static List<BoxShadow> get shadowSmLight => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.05),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];
  
  static List<BoxShadow> get shadowMdLight => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get shadowLgLight => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get shadowSmDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.15),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];
  
  static List<BoxShadow> get shadowMdDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.25),
      blurRadius: 15,
      offset: const Offset(0, 8),
    ),
  ];
  
  static List<BoxShadow> get shadowLgDark => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.35),
      blurRadius: 25,
      offset: const Offset(0, 12),
    ),
  ];
  
  static List<BoxShadow> get shadowPrimary => [
    BoxShadow(
      color: primary500.withValues(alpha: 0.3),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];
  
  // ============================
  // 6. ANIMATION
  // ============================
  
  /// Durations
  static const Duration durationInstant = Duration(milliseconds: 0);
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 350);
  static const Duration durationSlower = Duration(milliseconds: 500);
  
  /// Curves
  static const Curve curveEaseInOut = Curves.easeInOut;
  static const Curve curveEaseOut = Curves.easeOut;
  static const Curve curveEaseIn = Curves.easeIn;
  static const Curve curveBounce = Curves.elasticOut;
  static const Curve curveSmooth = Curves.fastOutSlowIn;
  
  // ============================
  // 7. BREAKPOINTS
  // ============================
  
  /// Mobile First Breakpoints
  static const double breakpointXs = 375.0;   // Small mobile
  static const double breakpointSm = 640.0;   // Mobile
  static const double breakpointMd = 768.0;   // Tablet
  static const double breakpointLg = 1024.0;  // Desktop
  static const double breakpointXl = 1280.0;  // Large desktop
  static const double breakpoint2xl = 1536.0; // Extra large
  
  /// Screen Size Helpers
  static bool isMobile(double width) => width < breakpointMd;
  static bool isTablet(double width) => width >= breakpointMd && width < breakpointLg;
  static bool isDesktop(double width) => width >= breakpointLg;
  static bool isWide(double width) => width >= breakpointLg;
  
  // ============================
  // 8. ACCESSIBILITY
  // ============================
  
  /// Minimum touch target (WCAG 2.1 AA)
  static const double minTouchTarget = 44.0;
  static const double minInteractiveElement = 44.0;
  
  /// Focus indicators
  static const double focusRingWidth = 2.0;
  static const Color focusRingColor = primary500;
  
  /// Minimum contrast ratios (WCAG 2.1 AA)
  static const double contrastRatioLarge = 3.0;  // 18pt+ text
  static const double contrastRatioNormal = 4.5; // Normal text
  static const double contrastRatioUi = 3.0;     // UI components
  
  /// Screen reader support
  static const String semanticLabelPrefix = 'VitalityAI';
  
  // ============================
  // 9. COMPONENT TOKENS
  // ============================
  
  /// Button Tokens
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 44.0;
  static const double buttonHeightLg = 52.0;
  
  static const double buttonPaddingHorizontalSm = 12.0;
  static const double buttonPaddingHorizontalMd = 20.0;
  static const double buttonPaddingHorizontalLg = 28.0;
  
  /// Input Tokens
  static const double inputHeight = 48.0;
  static const double inputPaddingHorizontal = 16.0;
  static const double inputBorderRadius = 12.0;
  
  /// Card Tokens
  static const double cardPadding = 24.0;
  static const double cardBorderRadius = 24.0;
  static const double cardBorderWidth = 1.0;
  
  /// Icon Tokens
  static const double iconSizeXs = 12.0;
  static const double iconSizeSm = 16.0;
  static const double iconSizeMd = 20.0;
  static const double iconSizeLg = 24.0;
  static const double iconSizeXl = 32.0;
  static const double iconSize2xl = 48.0;
  
  /// Modal/Dialog Tokens
  static const double modalBorderRadius = 32.0;
  static const double modalPadding = 24.0;
  static const double modalMaxWidth = 600.0;
  static const double modalMinHeight = 400.0;
  
  /// Navigation Tokens
  static const double navbarHeight = 70.0;
  static const double bottomNavHeight = 80.0;
  static const double navItemPadding = 12.0;
  
  /// Chart Tokens
  static const double chartHeightSm = 200.0;
  static const double chartHeightMd = 300.0;
  static const double chartHeightLg = 400.0;
  
  /// Avatar Tokens
  static const double avatarSizeSm = 32.0;
  static const double avatarSizeMd = 44.0;
  static const double avatarSizeLg = 80.0;
  static const double avatarSizeXl = 120.0;
  
  // ============================
  // HELPER METHODS
  // ============================
  
  /// Get color based on theme
  static Color getBackgroundColor(bool isDark) => isDark ? darkBg : lightBg;
  static Color getSurfaceColor(bool isDark) => isDark ? darkSurface : lightSurface;
  static Color getTextPrimary(bool isDark) => isDark ? darkTextPrimary : lightTextPrimary;
  static Color getTextSecondary(bool isDark) => isDark ? darkTextSecondary : lightTextSecondary;
  static Color getBorderColor(bool isDark) => isDark ? darkBorder : lightBorder;
  
  /// Get shadow based on theme
  static List<BoxShadow> getCardShadow(bool isDark) => isDark ? shadowMdDark : shadowMdLight;
  static List<BoxShadow> getButtonShadow(bool isDark) => isDark ? shadowSmDark : shadowSmLight;
  
  /// Get gradient based on theme
  static LinearGradient getSurfaceGradient(bool isDark) => 
      isDark ? surfaceGradientDark : surfaceGradientLight;
}