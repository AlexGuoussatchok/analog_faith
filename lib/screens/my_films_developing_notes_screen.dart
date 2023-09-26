import 'package:flutter/material.dart';

class MyFilmsDevelopingNotesScreen extends StatelessWidget {
  const MyFilmsDevelopingNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Films Developing Notes'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          // Add a menu icon with an option "Develop a Film"
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'develop_film') {
                // Handle the "Develop a Film" option here
                // You can navigate to the film development screen or perform any other action
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'develop_film',
                  child: Text('Develop a Film'),
                ),
                // Add more menu items if needed
              ];
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'This is the My Films Developing Notes Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
