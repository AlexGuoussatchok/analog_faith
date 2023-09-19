import 'package:flutter/material.dart';
import 'package:analog_faith/screens/cameras_catalogue_screen.dart';
import 'package:analog_faith/screens/lenses_catalogue_screen.dart'; // Import the Lenses Catalogue screen

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
        backgroundColor: Colors.grey, // Change AppBar color to gray
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the CamerasCatalogueScreen when the "Cameras" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CamerasCatalogueScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Cameras',
                  style: TextStyle(fontSize: 32), // Change the font size here
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the LensesCatalogueScreen when the "Lenses" button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LensesCatalogueScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Lenses',
                  style: TextStyle(fontSize: 32), // Change the font size here
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black, // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Add functionality for Films button
                  // Navigator.pushNamed(context, '/films'); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Films',
                  style: TextStyle(fontSize: 32), // Change the font size here
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
