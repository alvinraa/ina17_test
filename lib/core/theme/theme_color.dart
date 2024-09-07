import 'package:flutter/material.dart';

abstract class ThemeColor {
  Brightness get brightness;
  Color get primary;
  Color get primaryContainer;
  Color get secondary;
  Color get secondaryContainer;
  Color get tertiary;
  Color get tertiaryContainer;
  Color get surface;
  Color get outline;
  Color get outlineVariant;
  Color get error;
  Color get errorContainer;
  Color get onPrimary;
  Color get onPrimaryContainer;
  Color get onSecondary;
  Color get onSecondaryContainer;
  Color get onTertiary;
  Color get onTertiaryContainer;
  Color get onSurface;
  Color get onSurfaceVariant;
  Color get onError;
  Color get onErrorContainer;
  Color get divider;
  Color get shadow;
  Color get border;
  Color get sysPrimaryContainer;
  Color get surfaceContainer;
  Color get surfaceContainerHighest;
}
