import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';


class MyCamerasScreen extends StatefulWidget {
  const MyCamerasScreen({super.key});

  @override
  _MyCamerasScreenState createState() => _MyCamerasScreenState();
}

class _MyCamerasScreenState extends State<MyCamerasScreen> {
  // Initialize the database helper
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cameras'),
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder(
        // Use the database helper to fetch the camera inventory
        future: databaseHelper.getMyCameras(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No cameras in inventory.'));
          } else {
            // Display the list of cameras
            final camerasList = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: camerasList.length,
              itemBuilder: (context, index) {
                final camera = camerasList[index];
                return ListTile(
                  title: Text(camera['brand'] + ' ' + camera['model']),
                  subtitle: Text('Serial Number: ${camera['serial_number']}'),
                  // You can display more camera details here as needed
                  // Add edit and delete functionality if required
                );
              },
            );
          }
        },
      ),
      // Add a floating action button to add new cameras
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a screen to add new cameras (you can implement this screen)
          // Example: Navigator.pushNamed(context, '/inventory/add_camera');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
