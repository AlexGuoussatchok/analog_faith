import 'package:flutter/material.dart';

class CamerasCatalogueScreen extends StatelessWidget {
  const CamerasCatalogueScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cameras Catalogue'),
        backgroundColor: Colors.grey, // Change AppBar color to gray
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'This is the Cameras Catalogue Screen',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add functionality for Cameras Catalogue button
              },
              child: const Text('Button on Cameras Catalogue Screen'),
            ),
          ],
        ),
      ),
    );
  }
}
