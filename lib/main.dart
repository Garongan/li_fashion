import 'package:flutter/material.dart';
import 'package:li_fashion/shared/navigation_menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Li Fashion",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Inter',
        navigationBarTheme: const NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
            TextStyle(
              color: Color.fromRGBO(29, 170, 171, 1),
              fontSize: 10,
            ),
          ),
        ),
      ),
      home: const NavigationMenu(),
    );
  }
}
