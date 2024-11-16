import 'package:flutter/material.dart';

const Color seedColor = Color(0xfffeffdb);

const TextTheme customTextTheme = TextTheme(
  displayLarge: TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  ),
  displayMedium: TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
  ),
  displaySmall: TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.15,
  ),
  headlineLarge: TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.2,
  ),
  headlineMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.15,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.1,
  ),
  titleLarge: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.0,
  ),
  titleMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.1,
  ),
  titleSmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.1,
  ),
  bodyLarge: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.15,
  ),
  bodyMedium: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.25,
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    letterSpacing: 0.4,
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelMedium: TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelSmall: TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
);

const IconThemeData customIconThemeData = IconThemeData(
  size: 30,
  color: Color(0xff000000),
);

const InputDecorationTheme customInputDecorationTheme = InputDecorationTheme(
  hintStyle: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  border: InputBorder.none,
);

var lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    surface: const Color(0xfffefff3),
    onSurface: const Color(0xff000000),
    outline: const Color(0xffe2e2e2),
    primary: seedColor,
    secondary: const Color(0xffe4ad7f),
  ),
  fontFamily: 'Inter',
  textTheme: customTextTheme,
  iconTheme: customIconThemeData,
  inputDecorationTheme: customInputDecorationTheme,
);

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
    surface: const Color(0xff000000),
    onSurface: const Color(0xfffefff3),
    outline: const Color(0xffe2e2e2),
    primary: seedColor,
    secondary: const Color(0xffe4ad7f),
  ),
  fontFamily: 'Inter',
  textTheme: customTextTheme,
  iconTheme: customIconThemeData,
  inputDecorationTheme: customInputDecorationTheme,
);
