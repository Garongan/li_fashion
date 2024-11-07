import 'package:flutter/material.dart';

const Color seedColor = Color(0xfffeffdb);

var lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.light,
    surface: const Color(0xfffefff3),
    onSurface: const Color(0xff000000),
    outline: const Color(0xfff9f8e8),
    primary: seedColor,
    secondary: const Color(0xffe4ad7f),
  ),
  fontFamily: 'Inter',
);

var darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: seedColor,
    brightness: Brightness.dark,
    surface: const Color(0xff000000),
    onSurface: const Color(0xfffefff3),
    outline: const Color(0xfff9f8e8),
    primary: seedColor,
    secondary: const Color(0xffe4ad7f),
  ),
  fontFamily: 'Inter',
);
