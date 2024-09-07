import 'package:flutter/material.dart';
import 'package:ina17_test/core/theme/style.dart';
import 'package:ina17_test/core/theme/theme_color.dart';

class DarkColor implements ThemeColor {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  Color get divider => hexToColor('#282B25');

  @override
  Color get error => hexToColor('#C31515');

  @override
  Color get errorContainer => hexToColor('#93000A');

  @override
  Color get onError => hexToColor('#690007');

  @override
  Color get onErrorContainer => hexToColor('#FFB4AB');

  @override
  Color get onPrimary => hexToColor('#11140E');

  @override
  Color get onPrimaryContainer => hexToColor('#B8F397');

  @override
  Color get onSecondary => hexToColor('#283420');

  @override
  Color get onSecondaryContainer => hexToColor('#D9E7CB');

  @override
  Color get onSurface => hexToColor('#E3E3DC');

  @override
  Color get onSurfaceVariant => hexToColor('#C3C8BB');

  @override
  Color get onTertiary => hexToColor('#003738');

  @override
  Color get onTertiaryContainer => hexToColor('#BBEBEC');

  @override
  Color get primary => hexToColor('#D75549');

  @override
  Color get primaryContainer => hexToColor('#FF897E');

  @override
  Color get secondary => hexToColor('#4359AB');

  @override
  Color get secondaryContainer => hexToColor('#627DE3');

  @override
  Color get shadow => Colors.grey.shade800;

  @override
  Color get surface => hexToColor('#111315');

  @override
  Color get tertiary => hexToColor('#A0CFD0');

  @override
  Color get tertiaryContainer => hexToColor('#1E4E4E');

  @override
  Color get outline => hexToColor('#8D9286');

  @override
  Color get outlineVariant => hexToColor('#43483E');

  @override
  Color get border => hexToColor('#DDE0E7');

  @override
  Color get sysPrimaryContainer => hexToColor('#DDE1FF');

  @override
  Color get surfaceContainer => hexToColor('#11140E');
  @override
  Color get surfaceContainerHighest => hexToColor('#D9E1F8');
}
