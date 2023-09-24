import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddLensesScreen extends StatefulWidget {
  const AddLensesScreen({Key? key}) : super(key: key);

  @override
  _AddLensesScreenState createState() => _AddLensesScreenState();
}

class _AddLensesScreenState extends State<AddLensesScreen> {
  // Initialize the database helper
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();

  // Define TextEditingController for capturing user input
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController mountController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController pricePaidController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  List<String> lensBrands = [];
  List<String> lensModels = [];

  String selectedBrand = '';
  String selectedModel = '';

  Future<void> fetchLensBrands() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    final brands = await db.query('lenses_brands', columns: ['lenses_brand']);
    final uniqueBrands = <String>{};

    for (final brandMap in brands) {
      final brand = brandMap['lenses_brand'].toString();
      uniqueBrands.add(brand);
    }

    lensBrands = uniqueBrands.toList();
    lensBrands.sort();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> fetchLensModels(String brand) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    final tableName = '${brand.toLowerCase()}_lenses_catalogue'; // Generate the table name
    final models = await db.query(tableName, columns: ['model']);
    final uniqueModels = <String>{};

    for (final modelMap in models) {
      final model = modelMap['model'].toString();
      uniqueModels.add(model);
    }

    lensModels = uniqueModels.toList();
    lensModels.sort();

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLensBrands(); // Fetch lens brands when the screen initializes
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lenses'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Add form fields for lens information
            DropdownButtonFormField<String>(
              value: selectedBrand.isNotEmpty ? selectedBrand : lensBrands.isNotEmpty ? lensBrands[0] : null,
              items: lensBrands.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBrand = value!;
                  lensModels = []; // Clear the previous models when the brand changes
                });
                fetchLensModels(selectedBrand); // Fetch lens models based on the selected brand
              },
              decoration: const InputDecoration(labelText: 'Brand'),
            ),

            DropdownButtonFormField<String>(
              value: selectedModel.isNotEmpty && lensModels.contains(selectedModel) ? selectedModel : null,
              items: lensModels.map((String model) {
                return DropdownMenuItem<String>(
                  value: model,
                  child: Text(model),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedModel = value ?? '';
                });
              },
              decoration: const InputDecoration(labelText: 'Model'),
            ),
            TextFormField(
              controller: mountController,
              decoration: const InputDecoration(labelText: 'Mount'),
            ),
            TextFormField(
              controller: serialNumberController,
              decoration: const InputDecoration(labelText: 'Serial Number'),
            ),
            TextFormField(
              controller: purchaseDateController,
              decoration: const InputDecoration(labelText: 'Purchase Date'),
            ),
            TextFormField(
              controller: pricePaidController,
              decoration: const InputDecoration(labelText: 'Price Paid'),
              keyboardType: TextInputType.number,
            ),
            TextFormField(
              controller: conditionController,
              decoration: const InputDecoration(labelText: 'Condition'),
            ),
            TextFormField(
              controller: commentsController,
              decoration: const InputDecoration(labelText: 'Comments'),
            ),
            const SizedBox(height: 16.0), // Add spacing

            ElevatedButton(
              onPressed: () async {
                // Add a lens to the database
                await databaseHelper.addLens(
                  brandController.text,
                  modelController.text,
                  mountController.text,
                  serialNumberController.text,
                  purchaseDateController.text,
                  double.tryParse(pricePaidController.text) ?? 0.0,
                  conditionController.text,
                  commentsController.text,
                );

                // Navigate back to the My Lenses screen
                Navigator.pop(context);
              },
              child: const Text('Save Lens'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
    brandController.dispose();
    modelController.dispose();
    serialNumberController.dispose();
    purchaseDateController.dispose();
    pricePaidController.dispose();
    conditionController.dispose();
    commentsController.dispose();
    super.dispose();
  }
}
