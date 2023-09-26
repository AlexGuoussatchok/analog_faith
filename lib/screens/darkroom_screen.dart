import 'package:flutter/material.dart';

class DarkroomScreen extends StatelessWidget {
  const DarkroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Darkroom'),
        backgroundColor: Colors.grey,
      ),
      body: const Center(
        child: Text(
          'Welcome to the Darkroom!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
