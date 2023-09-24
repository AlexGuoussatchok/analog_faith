import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

class MyFilmsScreen extends StatefulWidget {
  const MyFilmsScreen({Key? key}) : super(key: key);

  @override
  _MyFilmsScreenState createState() => _MyFilmsScreenState();
}

class _MyFilmsScreenState extends State<MyFilmsScreen> {
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();

  List<Map<String, dynamic>> films = [];

  // @override
  // void initState() {
  //   super.initState();
  //   fetchFilms();
  // }
  //
  // Future<void> fetchFilms() async {
  //   final filmList = await databaseHelper.getFilms();
  //   setState(() {
  //     films = filmList;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Films'),
        backgroundColor: Colors.grey,
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_film') {
                Navigator.pushNamed(context, '/inventory/add_film');
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_film',
                  child: Text('Add Film'),
                ),
              ];
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: films.length,
        itemBuilder: (context, index) {
          final film = films[index];
          return ListTile(
            title: Text(film['name'] ?? ''),
            subtitle: Text(film['format'] ?? ''),
          );
        },
      ),
    );
  }
}
