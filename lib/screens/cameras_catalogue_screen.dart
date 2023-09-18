import 'package:analog_faith/screens/cameras_catalogue_details_screen.dart';
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
  Map<String, List<String>> brandModels = {}; // Store models for each brand
  Map<String, bool> isExpanded = {}; // Store expansion state for each brand

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
      for (final brand in brands) {
        isExpanded[brand] = false; // Initialize all brands as collapsed
      }
    });

    // Close the database
    await database.close();
  }

  Future<void> fetchCameraModels(String brand) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final database = await openDatabase(path, readOnly: true);

    final tableName = '${brand.toLowerCase()}_cameras_catalogue';
    final result = await database.rawQuery('''
      SELECT camera_name
      FROM $tableName
    ''');

    final models = result.map((row) => row['camera_name'] as String).toList();
    brandModels[brand] = models;

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
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black, // Border color
                        width: 1.0, // Border width
                      ),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!isExpanded[brand]!) {
                        await fetchCameraModels(brand);
                      }
                      setState(() {
                        isExpanded[brand] = !isExpanded[brand]!;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black, backgroundColor: Colors.grey,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, // Align text to the left
                      children: [
                        Text(
                          brand,
                          style: const TextStyle(
                            fontSize: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isExpanded[brand]!)
                  Column(
                    children: brandModels[brand]!.map((model) {
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
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => CameraCatalogueDetailsScreen(
                                  brand: brand,
                                  model: model, // Pass the selected model
                                ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black, backgroundColor: Colors.grey,
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.centerLeft,
                          ),
                          child: Center(
                            child: Text(
                              model,
                              style: const TextStyle(
                                fontSize: 32,
                              ),
                            ),
                          ),
                        ),

                      );
                    }).toList(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
