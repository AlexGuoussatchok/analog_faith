import 'package:flutter/material.dart';
import 'package:analog_faith/screens/edit_camera_screen.dart';
import 'package:analog_faith/screens/load_film_screen.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

class MyCamerasDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> cameraData;

  const MyCamerasDetailsScreen({Key? key, required this.cameraData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Details'),
        backgroundColor: Colors.grey,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              // Handle menu item selection here
              if (value == 'edit') {
                // Handle edit action
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return EditCameraScreen(cameraData: cameraData);
                }));
              } else if (value == 'delete') {
                // Handle delete action
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Delete Camera'),
                      content: const Text('Do you really want to delete this camera from inventory?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            // Dismiss the dialog
                            Navigator.of(context).pop();
                            // Call the deleteCamera method here with the camera's ID
                            InventoryDatabaseHelper().deleteCamera(cameraData['id']);
                            // You may also want to navigate back to the previous screen
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Dismiss the dialog
                            Navigator.of(context).pop();
                          },
                          child: const Text('No'),
                        ),
                      ],
                    );
                  },
                );
              } else if (value == 'load_film') {
                // Handle load film action
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoadFilmScreen(cameraData: cameraData);
                }));
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Delete'),
              ),
              const PopupMenuItem<String>(
                value: 'load_film',
                child: Text('Load Film'),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display camera details
            Text('Brand: ${cameraData['brand']}',
              style: const TextStyle(fontSize: 30),
            ),
            Text('Model: ${cameraData['model']}',
              style: const TextStyle(fontSize: 30),
            ),
            Text('Serial Number: ${cameraData['serial_number']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Purchase date: ${cameraData['purchase_date']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Price paid: ${cameraData['price_paid']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Condition: ${cameraData['condition']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Film loaded: ${cameraData['film_loaded']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Film load date: ${cameraData['film_load_date']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Average recent price: ${cameraData['average_price']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Comments: ${cameraData['comments']}',
              style: const TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}


