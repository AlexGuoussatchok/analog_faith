import 'package:flutter/material.dart';
import 'package:analog_faith/screens/catalogue_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analog Faith'),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CatalogueScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Catalogue',
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
                  // Add functionality for Inventory button
                  // Navigator.pushNamed(context, '/inventory'); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Inventory',
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
                  // Add functionality for Darkroom button
                  // Navigator.pushNamed(context, '/darkroom'); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'Darkroom',
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
