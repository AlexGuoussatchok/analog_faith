import 'package:analog_faith/screens/my_films_developing_notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/darkroom_notes_database_helper.dart';

class DarkroomScreen extends StatefulWidget {
  const DarkroomScreen({Key? key}) : super(key: key);

  @override
  _DarkroomScreenState createState() => _DarkroomScreenState();
}

class _DarkroomScreenState extends State<DarkroomScreen> {
  late DarkroomNotesDatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _databaseHelper = DarkroomNotesDatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    // Initialize the 'darkroom_notes' database when the screen opens
    _initializeDatabase();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Darkroom'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'develop_film') {
                // Handle the "Develop a Film" option here.
                // You can navigate to a screen for film development.
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
          if (buttonText == "My Films Developing Notes") {
            // Navigate to the My Films Developing Notes screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyFilmsDevelopingNotesScreen(),
              ),
            );
          } else {
            // Handle other button actions
          }
        },
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.grey,
          textStyle: const TextStyle(fontSize: 28),
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }

  Future<void> _initializeDatabase() async {
    await _databaseHelper.initializeDatabase();
  }
}
