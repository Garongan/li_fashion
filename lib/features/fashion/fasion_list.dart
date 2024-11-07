import 'package:flutter/material.dart';

class FasionList extends StatelessWidget {
  const FasionList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion List'),
      ),
      body: Container(
        color: colorScheme.onSurface,
        child: Center(
          child: SafeArea(
            child: Text(
              MediaQuery.platformBrightnessOf(context).name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: colorScheme.surface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
