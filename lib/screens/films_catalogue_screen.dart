import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class FilmsCatalogueScreen extends StatefulWidget {
  const FilmsCatalogueScreen({Key? key}) : super(key: key);

  @override
  _FilmsCatalogueScreenState createState() => _FilmsCatalogueScreenState();
}

class _FilmsCatalogueScreenState extends State<FilmsCatalogueScreen> {
  List<String>? filmBrands;
  Map<String, List<String>> brandFilms = {}; // Store films for each brand
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
    SELECT DISTINCT brand
    FROM film_brands
    ORDER BY brand ASC;
  ''');

    final brands = result.map((row) => row['brand'] as String).toList();
    setState(() {
      filmBrands = brands;
      for (final brand in brands) {
        isExpanded[brand] = false;
      }
    });

    await database.close();
  }

  Future<void> fetchBrandFilms(String brand, String tableName) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final database = await openDatabase(path, readOnly: true);

    final result = await database.rawQuery('''
    SELECT film_name
    FROM $tableName
  ''');

    if (result.isNotEmpty) {
      final films = result.map((row) => row['film_name'] as String).toList();
      brandFilms[brand] = films;
    } else {
      // Handle the case when no film names are found for this brand.
      // You can set brandFilms[brand] to an empty list or display a message.
      brandFilms[brand] = [];
    }

    await database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films Catalogue'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: filmBrands == null
            ? const CircularProgressIndicator()
            : ListView.builder(
          itemCount: filmBrands!.length,
          itemBuilder: (context, index) {
            final brand = filmBrands![index];
            final brandTableName = '${brand.toLowerCase()}_films_catalogue';
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
                        await fetchBrandFilms(brand, brandTableName);
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
                    children: brandFilms[brand]!.map((film) {
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
                            // Handle film selection if needed
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.grey,
                            padding: const EdgeInsets.all(16.0),
                            alignment: Alignment.center, // Center-align the text
                          ),
                          child: Center(
                            child: Text(
                              film,
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
