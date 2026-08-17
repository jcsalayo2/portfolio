import 'package:flutter/material.dart';

class PortfolioColors {
  static const background = Color(0xFF333333);
  static const surface = Color(0xFF2A2A2A);
  static const surfaceLight = Color(0xFF3D3D3D);
  static const accent = Colors.amber;
  static const textPrimary = Colors.white;
  static const textSecondary = Color(0xB3FFFFFF);
}

class PortfolioBreakpoints {
  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.sizeOf(context).width < 1024;

  static double horizontalPadding(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width < 768) return 20;
    if (width < 1024) return 48;
    return width * 0.125;
  }

  static double sectionPadding(BuildContext context) {
    if (isMobile(context)) return 0;
    if (isTablet(context)) return 48;
    return 120;
  }
}

class PortfolioTextStyles {
  static const sectionTitle = TextStyle(
    fontSize: 36,
    color: PortfolioColors.accent,
    fontFamily: 'PlayFair',
    fontVariations: [FontVariation('wght', 800)],
  );

  static TextStyle sectionTitleMobile(BuildContext context) =>
      sectionTitle.copyWith(fontSize: isMobile(context) ? 28 : 36);

  static bool isMobile(BuildContext context) =>
      PortfolioBreakpoints.isMobile(context);

  static const body = TextStyle(
    fontSize: 16,
    color: PortfolioColors.textPrimary,
    height: 1.6,
  );

  static const cardTitle = TextStyle(
    fontFamily: 'PlayFair',
    fontSize: 22,
    color: PortfolioColors.accent,
    fontVariations: [FontVariation('wght', 700)],
  );
}

ThemeData buildPortfolioTheme() {
  return ThemeData(
    fontFamily: 'OpenSans',
    scaffoldBackgroundColor: PortfolioColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: PortfolioColors.accent,
      brightness: Brightness.dark,
      surface: PortfolioColors.surface,
    ),
    useMaterial3: true,
    dividerTheme: const DividerThemeData(color: PortfolioColors.accent),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
  );
}
