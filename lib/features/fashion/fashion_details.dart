import 'package:flutter/material.dart';

class FashionDetails extends StatelessWidget {
  final String name;

  const FashionDetails({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
      ),
      body: Text(name),
    );
  }
}
