import 'package:flutter/material.dart';

class DarkroomScreen extends StatelessWidget {
  const DarkroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Darkroom'),
        backgroundColor: Colors.grey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildButton(context, "Button 1"), // Add as many buttons as needed
          _buildButton(context, "Button 2"),
          _buildButton(context, "My Films Developing Notes"),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context, String buttonText) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/darkroom/my_films_developing_notes');
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: Colors.grey, // Change the text color
          textStyle: const TextStyle(fontSize: 28), // Change the text size
          padding: const EdgeInsets.all(16), // Adjust the padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust the border radius
          ),
        ),
        child: Text(buttonText), // Replace with your button's name
      ),
    );
  }
}
