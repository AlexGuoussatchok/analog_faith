import 'package:analog_faith/screens/add_lenses_screen.dart';
import 'package:analog_faith/screens/my_lenses_screen.dart';
import 'package:flutter/material.dart';
import 'package:analog_faith/screens/home_screen.dart';
import 'package:analog_faith/screens/inventory_screen.dart';
import 'package:analog_faith/screens/my_cameras_screen.dart';
import 'package:analog_faith/screens/add_camera_screen.dart';
import 'package:analog_faith/screens/my_films_screen.dart';
import 'package:analog_faith/screens/add_film_screen.dart';
import 'package:analog_faith/screens/darkroom_screen.dart';

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
      routes: {
        '/': (context) => const HomeScreen(),
        '/inventory': (context) => InventoryScreen(),
        '/inventory/my_cameras': (context) => const MyCamerasScreen(),
        '/inventory/add_camera': (context) => const AddCameraScreen(),
        '/inventory/my_lenses': (context) => const MyLensesScreen(),
        '/inventory/add_lens': (context) => const AddLensesScreen(),
        '/inventory/my_films': (context) => const MyFilmsScreen(),
        '/inventory/add_film': (context) => const AddFilmScreen(),
        '/darkroom': (context) => const DarkroomScreen(),


        // Define other routes as needed
      },
      initialRoute: '/',
    );
  }
}
