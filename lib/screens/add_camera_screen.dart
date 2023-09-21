import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({Key? key}) : super(key: key);

  @override
  _AddCameraScreenState createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
  List<String> cameraBrands = [];
  String selectedBrand = ''; // Selected brand value

  // Define controllers for your text fields
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController pricePaidController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  final TextEditingController filmLoadedController = TextEditingController();
  final TextEditingController filmLoadDateController = TextEditingController();
  final TextEditingController averagePriceController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();


  Future<void> fetchCameraBrands() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    final brands = await db.query('camera_brands', columns: ['camera_brand']);
    final uniqueBrands = <String>{};

    for (final brandMap in brands) {
      final brand = brandMap['camera_brand'].toString();
      uniqueBrands.add(brand);
    }

    cameraBrands = uniqueBrands.toList();

    if (mounted) {
      setState(() {});
    }
  }


  @override
  void initState() {
    super.initState();
    fetchCameraBrands();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a Camera'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (cameraBrands.isNotEmpty) // Check if cameraBrands is not empty
                  DropdownButtonFormField<String>(
                    value: selectedBrand.isNotEmpty ? selectedBrand : cameraBrands[0], // Use the first brand as a default value
                    items: cameraBrands.map((String brand) {
                      return DropdownMenuItem<String>(
                        value: brand,
                        child: Text(brand),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedBrand = value!;
                      });
                    },
                    decoration: const InputDecoration(labelText: 'Brand'),
                  ),
              TextField(
                controller: modelController,
                decoration: const InputDecoration(labelText: 'Model'),
              ),
              TextField(
                controller: serialNumberController,
                decoration: const InputDecoration(labelText: 'Serial Number'),
              ),
              TextField(
                controller: purchaseDateController,
                decoration: const InputDecoration(labelText: 'Purchase date'),
              ),
              TextField(
                controller: pricePaidController,
                decoration: const InputDecoration(labelText: 'Price paid'),
              ),
              TextField(
                controller: conditionController,
                decoration: const InputDecoration(
                    labelText: 'Camera condition'),
              ),
              TextField(
                controller: filmLoadedController,
                decoration: const InputDecoration(labelText: 'Film loaded'),
              ),
              TextField(
                controller: filmLoadDateController,
                decoration: const InputDecoration(labelText: 'Film load date'),
              ),
              TextField(
                controller: averagePriceController,
                decoration: const InputDecoration(
                    labelText: 'Camera average price'),
              ),
              TextField(
                controller: commentsController,
                decoration: const InputDecoration(labelText: 'Comments'),
              ),
              // Add more text fields for other camera details
              ElevatedButton(
                onPressed: () {
                  // Retrieve the input values from the text controllers
                  final brand = brandController.text;
                  final model = modelController.text;
                  final serialNumber = serialNumberController.text;
                  final purchaseDate = purchaseDateController.text;
                  final pricePaid = pricePaidController.text;
                  final condition = conditionController.text;
                  final filmLoaded = filmLoadedController.text;
                  final filmLoadDate = filmLoadDateController.text;
                  final averagePrice = averagePriceController.text;
                  final comments = commentsController.text;
                  // Retrieve values for other fields similarly

                  // Now, you can save these values to your database using the InventoryDatabaseHelper
                  // Example: InventoryDatabaseHelper().addCamera(brand, model, serialNumber, ...);

                  // After saving, you can navigate back to the camera list screen
                  Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
