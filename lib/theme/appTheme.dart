import 'package:flutter/material.dart';

class AppTheme {
  static const Color terminalDark = Color(0xFF00FF66);
  static const Color terminalDarkBackground = Color(0xFF050505);

  static const Color terminalLight = Color(0xFF0000AA);
  static const Color terminalLightBackground = Color(0xFFd3d7cf);

  static ThemeData light = ThemeData(
    brightness: Brightness.light,

    // Fundo geral
    scaffoldBackgroundColor: terminalLightBackground,

    // Sistema de cores usado pelo Flutter
    colorScheme: const ColorScheme.light(
      primary: terminalLight,
      secondary: terminalLight,
      surface: terminalLightBackground,

      onPrimary: terminalLightBackground,
      onSecondary: terminalLightBackground,
      onSurface: terminalLight,
    ),

    // Textos
    textTheme: const TextTheme(bodyMedium: TextStyle(color: terminalLight)),

    // Ícones
    iconTheme: const IconThemeData(color: terminalLight),

    // Cards
    cardTheme: const CardThemeData(
      color: terminalLightBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: terminalLight, width: 1),
      ),
    ),
  );

  static ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    // Fundo geral
    scaffoldBackgroundColor: terminalDarkBackground,

    // Sistema de cores usado pelo Flutter
    colorScheme: const ColorScheme.dark(
      primary: terminalDark,
      secondary: terminalDark,
      surface: terminalDarkBackground,

      onPrimary: terminalDarkBackground,
      onSecondary: terminalDarkBackground,
      onSurface: terminalDark,
    ),

    // Textos
    textTheme: const TextTheme(bodyMedium: TextStyle(color: terminalDark)),

    // Ícones
    iconTheme: const IconThemeData(color: terminalDark),

    // Cards
    cardTheme: const CardThemeData(
      color: terminalDarkBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: terminalDark, width: 1),
      ),
    ),
  );
}
