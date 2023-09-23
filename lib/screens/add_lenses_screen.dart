import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

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
            TextFormField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextFormField(
              controller: modelController,
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
