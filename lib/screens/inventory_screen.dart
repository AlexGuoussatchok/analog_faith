import 'package:flutter/material.dart';

class InventoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to the My Cameras screen when the My Cameras button is pressed.
                Navigator.pushNamed(context, '/inventory/my_cameras');
              },
              child: Text('My Cameras'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the My Lenses screen when the My Lenses button is pressed.
                Navigator.pushNamed(context, '/inventory/my_lenses');
              },
              child: Text('My Lenses'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to the My Films screen when the My Films button is pressed.
                Navigator.pushNamed(context, '/inventory/my_films');
              },
              child: Text('My Films'),
            ),
          ],
        ),
      ),
    );
  }
}
