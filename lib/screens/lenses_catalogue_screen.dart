import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class LensesCatalogueScreen extends StatefulWidget {
  const LensesCatalogueScreen({Key? key}) : super(key: key);

  @override
  _LensesCatalogueScreenState createState() => _LensesCatalogueScreenState();
}

class _LensesCatalogueScreenState extends State<LensesCatalogueScreen> {
  List<String>? lensBrands;
  Map<String, List<String>> brandModels = {}; // Store models for each brand
  Map<String, bool> isExpanded = {}; // Store expansion state for each brand

  @override
  void initState() {
    super.initState();
    initializeDatabaseAndLoadData();
  }

  Future<void> initializeDatabaseAndLoadData() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');

    if (await databaseExists(path)) {
      // If it exists, there's no need to copy it again.
    } else {
      final ByteData data = await rootBundle.load('assets/catalogue.db');
      final List<int> bytes = data.buffer.asUint8List();
      await File(path).writeAsBytes(bytes, flush: true);
    }

    final database = await openDatabase(
      path,
      readOnly: true,
    );

    final result = await database.rawQuery('''
    SELECT DISTINCT lenses_brand
    FROM lenses_brands
    ORDER BY lenses_brand ASC;
  ''');

    final brands = result.map((row) => row['lenses_brand'] as String).toList();
    setState(() {
      lensBrands = brands;
      for (final brand in brands) {
        isExpanded[brand] = false;
      }
    });

    await database.close();
  }

  Future<void> fetchLensModels(String brand, String tableName) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final database = await openDatabase(path, readOnly: true);

    final result = await database.rawQuery('''
    SELECT model
    FROM $tableName
  ''');

    if (result.isNotEmpty) {
      final models = result.map((row) => row['model'] as String).toList();
      brandModels[brand] = models;
    } else {
      // Handle the case when no lens models are found for this brand.
      // You can set brandModels[brand] to an empty list or display a message.
      brandModels[brand] = [];
    }

    await database.close();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lenses Catalogue'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: lensBrands == null
            ? const CircularProgressIndicator()
            : ListView.builder(
          itemCount: lensBrands!.length,
          itemBuilder: (context, index) {
            final brand = lensBrands![index];
            return Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (!isExpanded[brand]!) {
                        await fetchLensModels(brand, '${brand.toLowerCase().replaceAll(' ', '_')}_lenses_catalogue');
                      }
                      setState(() {
                        isExpanded[brand] = !isExpanded[brand]!;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              color: Colors.black,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle lens model selection if needed
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey,
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
