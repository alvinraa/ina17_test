import 'package:flutter/material.dart';
import 'package:ina17_test/core/theme/style.dart';
import 'package:ina17_test/core/theme/theme_color.dart';

class LightColor implements ThemeColor {
  @override
  Brightness get brightness => Brightness.light;

  @override
  Color get divider => hexToColor('#E7E9DF');

  @override
  Color get error => hexToColor('#BA1A1A');

  @override
  Color get errorContainer => hexToColor('#FFDAD6');

  @override
  Color get onError => hexToColor('#FFFFFF');

  @override
  Color get onErrorContainer => hexToColor('#410005');

  @override
  Color get onPrimary => hexToColor('#FFFFFF');

  @override
  Color get onPrimaryContainer => hexToColor('#092100');

  @override
  Color get onSecondary => hexToColor('#FFFFFF');

  @override
  Color get onSecondaryContainer => hexToColor('#14200D');

  @override
  Color get onSurface => hexToColor('#1A1C18');

  @override
  Color get onSurfaceVariant => hexToColor('#43483E');

  @override
  Color get onTertiary => hexToColor('#FFFFFF');

  @override
  Color get onTertiaryContainer => hexToColor('#002020');

  @override
  Color get primary => hexToColor('#D75549');

  @override
  Color get primaryContainer => hexToColor('#FF897E');

  @override
  Color get secondary => hexToColor('#273569');

  @override
  Color get secondaryContainer => hexToColor('#5369BB');

  @override
  Color get shadow => Colors.grey.shade300;

  @override
  Color get surface => hexToColor('#FBFBFB');

  @override
  Color get tertiary => hexToColor('#386666');

  @override
  Color get tertiaryContainer => hexToColor('#BBEBEC');

  @override
  Color get outline => hexToColor('#8D9286');

  @override
  Color get outlineVariant => hexToColor('#43483E');

  @override
  Color get border => hexToColor('#6C717B');

  @override
  Color get sysPrimaryContainer => hexToColor('#DDE1FF');

  @override
  Color get surfaceContainer => hexToColor('#FFFFFF');

  @override
  Color get surfaceContainerHighest => hexToColor('#D9E1F8');
}
