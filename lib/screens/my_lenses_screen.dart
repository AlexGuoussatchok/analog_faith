import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

class MyLensesScreen extends StatefulWidget {
  const MyLensesScreen({super.key});

  @override
  _MyLensesScreenState createState() => _MyLensesScreenState();
}

class _MyLensesScreenState extends State<MyLensesScreen> {
  // Initialize the database helper
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lenses'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_lens') {
                // Handle the "Add a Lens" option here, navigate to the add lens screen.
                Navigator.pushNamed(context, '/inventory/add_lens');
              }
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_lens',
                  child: Text('Add a Lens'),
                ),
                // Add more menu items if needed
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder(
        // Use the database helper to fetch the lens inventory
        future: databaseHelper.getMyLenses(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No lenses in inventory.'));
          } else {
            // Display the list of lenses
            final lensesList = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: lensesList.length,
              itemBuilder: (context, index) {
                final lens = lensesList[index];
                return ListTile(
                  title: Text(lens['brand'] + ' ' + lens['model']),
                  subtitle: Text('Serial Number: ${lens['serial_number']}'),
                  // You can display more lens details here as needed
                  // Add edit and delete functionality if required
                );
              },
            );
          }
        },
      ),
    );
  }
}
