import 'package:flutter/material.dart';
import 'package:analog_faith/screens/home_screen.dart';
import 'package:analog_faith/screens/inventory_screen.dart';
import 'package:analog_faith/screens/my_cameras_screen.dart';

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
      // Define your routes here
      routes: {
        '/': (context) => const HomeScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/inventory/my_cameras': (context) => MyCamerasScreen(),
        // Define other routes as needed
      },
      initialRoute: '/',
    );
  }
}
