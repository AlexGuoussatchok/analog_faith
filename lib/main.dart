import 'package:flutter/material.dart';
import 'package:analog_faith/screens/home_screen.dart';

void main() {
  runApp(const AnalogFaithApp());
}

class AnalogFaithApp extends StatelessWidget {
  const AnalogFaithApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Analog Faith',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeArea(
        // Wrap your HomeScreen with SafeArea
        child: HomeScreen(),
      ),
    );
  }
}
