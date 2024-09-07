import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ina17_test/core/theme/dark_color.dart';
import 'package:ina17_test/core/theme/light_color.dart';
import 'package:ina17_test/core/theme/theme_color.dart';

/// USAGE
// Styles._singleton.color.primary
// Styles.padding.pagePaddingSymetricHorizontal
// Theme.of(context).textTheme.titleLarge,
// Theme.of(context).colorScheme.primary,
// Theme.of(context).colorScheme.secondary,

class Styles {
  /// Theme
  late ThemeType theme;

  /// Color
  ThemeColor color = LightColor();

  /// Padding
  static final padding = ThemePadding();

  /// Padding
  static final margin = ThemeMargin();

  /// Radius
  static final radius = ThemeRadius();

  Styles._internal();

  static final Styles _singleton = Styles._internal();

  factory Styles() {
    return _singleton;
  }

  void setTheme(ThemeType themeType) {
    _singleton.theme = themeType;
    setColor(themeType);
  }

  static setColor(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        _singleton.color = LightColor();
        break;
      case ThemeType.dark:
        _singleton.color = DarkColor();
        break;
      default:
        _singleton.color = LightColor();
        break;
    }
  }

  /// Dark Theme
  static ThemeData appTheme(BuildContext context, ThemeType themeType) {
    return ThemeData(
        colorScheme: ColorScheme.light(
          primary: _singleton.color.primary,
          primaryContainer: _singleton.color.primaryContainer,
          secondary: _singleton.color.secondary,
          secondaryContainer: _singleton.color.secondaryContainer,
          tertiary: _singleton.color.tertiary,
          tertiaryContainer: _singleton.color.tertiaryContainer,
          surface: _singleton.color.surface,
          error: _singleton.color.error,
          errorContainer: _singleton.color.errorContainer,
          onPrimary: _singleton.color.onPrimary,
          onPrimaryContainer: _singleton.color.onPrimaryContainer,
          onSecondary: _singleton.color.onSecondary,
          onTertiary: _singleton.color.onTertiary,
          onTertiaryContainer: _singleton.color.tertiaryContainer,
          onSurface: _singleton.color.onSurface,
          onSurfaceVariant: _singleton.color.onSurfaceVariant,
          onError: _singleton.color.onError,
          brightness: _singleton.color.brightness,
          shadow: _singleton.color.shadow,
          surfaceTint: Colors.transparent,
          surfaceContainer: _singleton.color.surfaceContainer,
          surfaceContainerHighest: _singleton.color.surfaceContainerHighest,
        ),
        scaffoldBackgroundColor: _singleton.color.surface,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(
            color: _singleton.color.onSurface, //change your color here
          ),
          surfaceTintColor: Colors.transparent,
          titleTextStyle: GoogleFonts.poppins(
            color: _singleton.color.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        brightness: _singleton.color.brightness,
        splashColor: _singleton.color.surface,
        dialogBackgroundColor: _singleton.color.surfaceContainer,
        primarySwatch: Colors.grey,
        primaryColor: _singleton.color.primary,
        primaryColorDark: _singleton.color.primary,
        textTheme: _globalTextTheme(context),
        dividerColor: _singleton.color.divider,
        dividerTheme: DividerThemeData(color: _singleton.color.divider),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _singleton.color.secondary;
            }
            return null;
          }),
        ),
        radioTheme: RadioThemeData(
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _singleton.color.secondary;
            }
            return null;
          }),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.grey.shade400; // your disabled color
              }
              return _singleton
                  .color.primary; // defer to the default enabled color
            },
          ),
          foregroundColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.disabled)) {
                return Colors.white; // your disabled color
              }
              return null; // defer to the default enabled color
            },
          ),
        )),
        tabBarTheme: TabBarTheme(
            dividerColor: Colors.transparent,
            overlayColor: WidgetStateProperty.all(
                _singleton.color.secondary.withOpacity(0.1))));
  }

  static _globalTextTheme(BuildContext context) {
    return GoogleFonts.ubuntuTextTheme(
      Theme.of(context).textTheme.copyWith(
            displayLarge: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            displayMedium:
                GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            displaySmall: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            headlineMedium:
                GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            headlineSmall:
                GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            titleLarge: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            titleMedium: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            titleSmall: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            bodyLarge: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            bodyMedium: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            labelLarge: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            bodySmall: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
            labelSmall: GoogleFonts.ubuntu(color: _singleton.color.onSurface),
          ),
    );
  }

  // Responsive size
  static double responsiveSize({
    required BuildContext context,
    required double largeValue,
    required double mediumValue,
    required double smallValue,
    required double xtraSmallValue,
  }) {
    if (Responsive.isLargeScreen(context)) {
      return largeValue;
    } else if (Responsive.isMediumScreen(context)) {
      return mediumValue;
    } else if (Responsive.isSmallScreen(context)) {
      return smallValue;
    } else {
      return xtraSmallValue;
    }
  }

  /// Responsive widget
  static Widget responsiveWidget({
    required BuildContext context,
    required Widget largeValue,
    required Widget mediumValue,
    required Widget smallValue,
    required Widget xtraSmallValue,
  }) {
    if (Responsive.isLargeScreen(context)) {
      return largeValue;
    } else if (Responsive.isMediumScreen(context)) {
      return mediumValue;
    } else if (!Responsive.isXtraSmallScreen(context)) {
      return smallValue;
    } else {
      return xtraSmallValue;
    }
  }

  /// Responsive stirng
  static String responsiveString({
    required BuildContext context,
    required String largeValue,
    required String mediumValue,
    required String smallValue,
    required String xtraSmallValue,
  }) {
    if (Responsive.isLargeScreen(context)) {
      return largeValue;
    } else if (Responsive.isMediumScreen(context)) {
      return mediumValue;
    } else if (!Responsive.isXtraSmallScreen(context)) {
      return smallValue;
    } else {
      return xtraSmallValue;
    }
  }
}

/* APP PADDING CLASS */
class ThemePadding {
  double p4 = 4;
  double p8 = 8;
  double p12 = 12;
  double p16 = 16;
  double p20 = 20;
  double p24 = 24;
  double p32 = 32;
  double p40 = 40;
}

/* APP PADDING CLASS */
class ThemeMargin {
  double m4 = 4;
  double m8 = 8;
  double m12 = 12;
  double m16 = 16;
  double m20 = 20;
  double m24 = 24;
  double m32 = 32;
  double m40 = 40;
}

/* APP RADIUS CLASS */
class ThemeRadius {
  double r4 = 4;
  double r6 = 6;
  double r8 = 8;
  double r12 = 12;
  double r16 = 16;
  double r24 = 24;
  double r32 = 32;
  double r48 = 48;
}

/* RESPONSIVE CLASS */
class Responsive extends StatelessWidget {
  final Widget largeScreen;
  final Widget mediumScreen;
  final Widget smallScreen;
  final Widget xtraSmallScreen;

  static const double largeScreenValue = 1007;
  static const double mediumScreenValue = 640;
  static const double smallScreenValue = 400;

  const Responsive({
    super.key,
    required this.largeScreen,
    required this.mediumScreen,
    this.smallScreen = const SizedBox(),
    this.xtraSmallScreen = const SizedBox(),
  });

  @override
  Widget build(BuildContext context) {
    // Returns the widget which is more appropriate for the screen size
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth >= largeScreenValue) {
        return largeScreen;
      } else if (constraints.maxWidth >= mediumScreenValue &&
          constraints.maxWidth < largeScreenValue) {
        return mediumScreen;
      } else if (constraints.maxWidth >= smallScreenValue &&
          constraints.maxWidth < mediumScreenValue) {
        return smallScreen;
      } else {
        return xtraSmallScreen;
      }
    });
  }

  // Large screen
  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeScreenValue;
  }

  // Medium screen
  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenValue &&
        MediaQuery.of(context).size.width < largeScreenValue;
  }

  // Small screen
  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= smallScreenValue &&
        MediaQuery.of(context).size.width < mediumScreenValue;
  }

  /// Xtra small screen
  static bool isXtraSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < smallScreenValue;
  }
}

Color hexToColor(String code) {
  return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

/* THEME TYPE CUSTOM */
enum ThemeType { light, dark }

extension ResultTypeExtension on ThemeType {
  String get value {
    switch (this) {
      case ThemeType.light:
        return 'light';
      case ThemeType.dark:
        return 'dark';
      default:
        return 'light';
    }
  }
}
