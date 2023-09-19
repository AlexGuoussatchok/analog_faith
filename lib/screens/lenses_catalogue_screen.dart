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
    ORDER BY lenses_brand ASC; // Sort brands alphabetically
  ''');

    final brands = result.map((row) => row['lenses_brand'] as String).toList();
    setState(() {
      lensBrands = brands;
    });

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
            ? CircularProgressIndicator()
            : ListView.builder(
          itemCount: lensBrands!.length,
          itemBuilder: (context, index) {
            final brand = lensBrands![index];
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
