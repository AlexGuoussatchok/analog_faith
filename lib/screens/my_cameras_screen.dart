import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';
import 'package:analog_faith/screens/my_cameras_details_screen.dart';


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
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_camera') {
                // Handle the "Add a Camera" option here, navigate to the add camera screen.
                Navigator.pushNamed(context, '/inventory/add_camera');
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_camera',
                  child: Text('Add a Camera'),
                ),
                // Add more menu items if needed
              ];
            },
          ),

        ],
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
                return InkWell(
                  onTap: () {
                    // Navigate to MyCamerasDetailsScreen and pass camera data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCamerasDetailsScreen(
                          cameraData: camera,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(camera['brand'] + ' ' + camera['model']),
                    subtitle: Text('Serial Number: ${camera['serial_number']}'),
                    // You can display more camera details here as needed
                    // Add edit and delete functionality if required
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

