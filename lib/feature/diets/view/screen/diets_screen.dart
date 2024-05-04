import 'package:flutter/material.dart';

class DietsScreen extends StatelessWidget {
  const DietsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Screen'),
      ),
      body: const Center(
        child: Text('Meal Screen'),
      ),
    );
  }
}
