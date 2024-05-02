import 'package:flutter/material.dart';
import 'package:nourish_me/core/imports/questions_screen_imports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('النتائج'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
