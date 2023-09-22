import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

class MyLensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lenses'),
        backgroundColor: Colors.grey,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: InventoryDatabaseHelper().getMyLenses(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Handle displaying the lens data here
            // You can use ListView.builder to display a list of lenses
            // Each item in the list will represent a lens entry
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                // Extract lens data from the snapshot
                final lensData = snapshot.data![index];

                // Create a widget to display lens data (e.g., ListTile)
                // You can customize this widget based on your UI requirements
                return ListTile(
                  title: Text(lensData['brand'] + ' ' + lensData['model']),
                  // Add more fields as needed (e.g., serial number, price, etc.)
                );
              },
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Text('Error: ${snapshot.error}');
          } else {
            // Display a loading indicator while data is being fetched
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
