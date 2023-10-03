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
import 'package:analog_faith/screens/my_films_developing_notes_screen.dart';
import 'package:permission_handler/permission_handler.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check and request necessary permissions
  await checkAndRequestPermissions();

  runApp(const AnalogFaithApp());
}

Future<void> checkAndRequestPermissions() async {
  // List the permissions your app needs
  final permissions = [
    Permission.storage,
    // Add more permissions if needed
  ];

  // Request multiple permissions at once
  final statuses = await permissions.request();

  // Check if all permissions are granted
  if (statuses.values.every((status) => status.isGranted)) {

    // All permissions are granted, you can proceed with your app
  } else {
    // Handle the case where some permissions are not granted
    // You can show a message to the user or take appropriate action
  }
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
        '/darkroom/my_films_developing_notes': (context) => const MyFilmsDevelopingNotesScreen(),



        // Define other routes as needed
      },
      initialRoute: '/',
    );
  }
}
