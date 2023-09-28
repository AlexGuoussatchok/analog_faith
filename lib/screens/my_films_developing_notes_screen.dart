import 'package:flutter/material.dart';
import 'package:analog_faith/screens/develop_new_film_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MyFilmsDevelopingNotesScreen extends StatefulWidget {
  const MyFilmsDevelopingNotesScreen({Key? key}) : super(key: key);

  @override
  _MyFilmsDevelopingNotesScreenState createState() =>
      _MyFilmsDevelopingNotesScreenState();
}

class _MyFilmsDevelopingNotesScreenState
    extends State<MyFilmsDevelopingNotesScreen> {
  List<Map<String, dynamic>> filmDevelopingNotes = [];

  @override
  void initState() {
    super.initState();
    // Fetch data when the screen is initialized
    fetchFilmDevelopingNotes().then((notes) {
      setState(() {
        // Sort the notes by date (primary) and film_number (secondary)
        filmDevelopingNotes = notes
          ..sort((a, b) {
            final dateA = a['date'] as String? ?? '';
            final dateB = b['date'] as String? ?? '';
            final filmNumberA = a['film_number'] as int?;
            final filmNumberB = b['film_number'] as int?;

            // Compare by date (primary)
            final dateComparison = dateB.compareTo(dateA);

            // If dates are the same, compare by film_number (secondary)
            if (dateComparison == 0) {
              return (filmNumberA ?? 0).compareTo(filmNumberB ?? 0);
            }

            return dateComparison;
          });
      });
    });
  }

  Future<List<Map<String, dynamic>>> fetchFilmDevelopingNotes() async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'darkroom_notes.db'),
      version: 1,
    );

    // Fetch data from the film_developing_notes table
    final List<Map<String, dynamic>> filmDevelopingNotes =
    await database.query('film_developing_notes');

    return filmDevelopingNotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Films Developing Notes'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'develop_film') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DevelopNewFilmScreen()),
                );
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
      body: ListView.builder(
        itemCount: filmDevelopingNotes.length,
        itemBuilder: (context, index) {
          final note = filmDevelopingNotes[index];
          final date = note['date'] as String? ?? 'N/A';
          final filmNumber = note['film_number'] as int?;
          final film = note['film'] as String?;

          return ListTile(
            title: Text('Date: $date'),
            subtitle: Text('Film Number: ${filmNumber ?? 'N/A'}, Film: $film'),
          );
        },
      ),
    );
  }
}
