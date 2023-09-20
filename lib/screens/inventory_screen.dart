import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventory'),
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
                  // Navigate to the My Cameras screen when the My Cameras button is pressed.
                  Navigator.pushNamed(context, '/inventory/my_cameras');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'My Cameras',
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
                  // Navigate to the My Lenses screen when the My Lenses button is pressed.
                  Navigator.pushNamed(context, '/inventory/my_lenses');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'My Lenses',
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
                  // Navigate to the My Films screen when the My Films button is pressed.
                  Navigator.pushNamed(context, '/inventory/my_films');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey, // Change button color to gray
                ),
                child: const Text(
                  'My Films',
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
