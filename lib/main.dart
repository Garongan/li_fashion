import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:li_fashion/shared/navigation_menu.dart';

void main() {
  // runApp(
  //   DevicePreview(
  //     enabled: !kReleaseMode,
  //     builder: (context) => const MyApp(), // Wrap your app
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color seedColor = Color(0xfffeffdb);

    return MaterialApp(
      title: "Li Fashion",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
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
        textTheme: GoogleFonts.interTextTheme(),
      ),
      darkTheme: ThemeData(
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
        textTheme: GoogleFonts.interTextTheme(),
      ),
      themeMode: ThemeMode.system,
      home: const NavigationMenu(),
    );
  }
}
