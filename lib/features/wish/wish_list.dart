import 'package:flutter/material.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wish List'),
      ),
      body: const Center(
        child: Text(
          'Wish List',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}