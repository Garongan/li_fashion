import 'package:flutter/material.dart';

class FasionsList extends StatelessWidget {
  const FasionsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion List'),
      ),
      body: const Center(
        child: SafeArea(
          child: Text(
            'Fashion List',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
