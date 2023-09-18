import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class CamerasCatalogueScreen extends StatefulWidget {
  const CamerasCatalogueScreen({Key? key}) : super(key: key);

  @override
  _CamerasCatalogueScreenState createState() => _CamerasCatalogueScreenState();
}

class _CamerasCatalogueScreenState extends State<CamerasCatalogueScreen> {
  List<String> cameraBrands = []; // Store unique camera brands here

  @override
  void initState() {
    super.initState();
    initializeDatabaseAndLoadData();
  }

  Future<void> initializeDatabaseAndLoadData() async {
    // Ensure the database is copied to internal storage
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');

    // Check if the database file already exists in internal storage
    if (await databaseExists(path)) {
      // If it exists, there's no need to copy it again.
    } else {
      // Copy the database from assets to internal storage
      final ByteData data = await rootBundle.load('assets/catalogue.db');
      final List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }

    // Open the database from internal storage
    final database = await openDatabase(
      path, // Use the internal storage path
      readOnly: true,
    );

    // Query for unique camera brands
    final result = await database.rawQuery('''
    SELECT DISTINCT camera_brand
    FROM camera_brands
  ''');

    // Extract the unique camera brands and update the state
    final brands = result.map((row) => row['camera_brand'] as String).toList();
    setState(() {
      cameraBrands = brands;
    });

    // Close the database
    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cameras Catalogue'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: ListView.builder(
          itemCount: cameraBrands.length,
          itemBuilder: (context, index) {
            final brand = cameraBrands[index];
            return Container(
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black, // Border color
                    width: 1.0, // Border width
                  ),
                ),
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Handle selection change if needed
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.grey, // Text color
                  padding: const EdgeInsets.all(16.0), // Adjust padding
                  alignment: Alignment.centerLeft, // Align text to the left
                ),
                child: DropdownButton<String>(
                  value: brand, // Set the selected value
                  onChanged: (value) {
                    // Handle selection change if needed
                  },
                  items: [
                    DropdownMenuItem(
                      value: brand,
                      child: Text(
                        brand,
                        style: const TextStyle(
                          color: Colors.black, // Text color
                          fontSize: 24, // Adjust font size
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
