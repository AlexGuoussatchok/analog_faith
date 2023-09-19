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
    });

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
                  // Handle brand selection if needed
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
            );
          },
        ),
      ),
    );
  }
}
