import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddFilmScreen extends StatefulWidget {
  const AddFilmScreen({Key? key}) : super(key: key);

  @override
  _AddFilmScreenState createState() => _AddFilmScreenState();
}

class _AddFilmScreenState extends State<AddFilmScreen> {
  TextEditingController brandController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController filmTypeController = TextEditingController();
  TextEditingController filmSizeController = TextEditingController();
  TextEditingController isoController = TextEditingController();
  TextEditingController framesNumberController = TextEditingController();
  TextEditingController filmExpiredController = TextEditingController();
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController pricePaidController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  List<String> brandList = [];
  List<String> filmNameList = [];

  @override
  void initState() {
    super.initState();
    // Load the brands from the database when the screen initializes
    fetchBrands();

    // Set the initial value for brandController if brandList is not empty
    if (brandList.isNotEmpty) {
      brandController.text = brandList.first;
    }
  }

  Future<void> fetchBrands() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    final brands = await db.query('film_brands', columns: ['brand']);
    final uniqueBrands = <String>{};

    for (final brandMap in brands) {
      final brand = brandMap['brand'].toString();
      uniqueBrands.add(brand);
    }

    // Convert the unique brands to a list and sort them
    brandList = uniqueBrands.toList()..sort();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchFilmNames(String selectedBrand) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    // Construct the table name dynamically.
    final tableName = '${selectedBrand.toLowerCase()}_films_catalogue';

    final filmNames = await db.query(tableName, columns: ['film_name']);
    final uniqueFilmNames = <String>{};

    for (final filmNameMap in filmNames) {
      final filmName = filmNameMap['film_name'].toString();
      uniqueFilmNames.add(filmName);
    }

    // Convert the unique film names to a list and sort them.
    filmNameList = uniqueFilmNames.toList()..sort();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Film'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            DropdownButtonFormField<String>(
              value: brandController.text.isNotEmpty ? brandController.text : null,
              items: brandList.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  brandController.text = value ?? '';

                  // Reset the film name when the brand changes
                  nameController.text = '';

                  // Fetch film names based on the selected brand.
                  fetchFilmNames(value ?? '');
                });
              },
              decoration: const InputDecoration(labelText: 'Brand'),
            ),


            DropdownButtonFormField<String>(
              value: nameController.text.isNotEmpty ? nameController.text : null,
              items: filmNameList.map((String filmName) {
                return DropdownMenuItem<String>(
                  value: filmName,
                  child: Text(filmName),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  nameController.text = value ?? '';
                });
              },
              decoration: const InputDecoration(labelText: 'Film Name'),
            ),


            TextFormField(
              controller: filmTypeController,
              decoration: const InputDecoration(labelText: 'Film Type'),
            ),
            TextFormField(
              controller: filmSizeController,
              decoration: const InputDecoration(labelText: 'Film Size'),
            ),
            TextFormField(
              controller: isoController,
              decoration: const InputDecoration(labelText: 'Film ISO'),
              ),
            TextFormField(
              controller: framesNumberController,
              decoration: const InputDecoration(labelText: 'Frames Number'),
            ),
            TextFormField(
              controller: filmExpiredController,
              decoration: const InputDecoration(labelText: 'Is Film Expired'),
            ),
            TextFormField(
              controller: expirationDateController,
              decoration: const InputDecoration(labelText: 'Film Expiration date'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Films Quantity'),
            ),
            TextFormField(
              controller: pricePaidController,
              decoration: const InputDecoration(labelText: 'Price Paid'),
            ),
            TextFormField(
              controller: commentsController,
              decoration: const InputDecoration(labelText: 'Comments'),
            ),

            ElevatedButton(
              onPressed: () {
                // Add film to the database or perform the desired action
                // You can access the entered values using nameController.text and formatController.text
                // Add your logic here
              },
              child: const Text('Save Film'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    brandController.dispose();
    nameController.dispose();
    filmTypeController.dispose();
    filmSizeController.dispose();
    isoController.dispose();
    framesNumberController.dispose();
    filmExpiredController.dispose();
    expirationDateController.dispose();
    quantityController.dispose();
    pricePaidController.dispose();
    commentsController.dispose();
    super.dispose();
  }
}
