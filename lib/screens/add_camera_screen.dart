import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'package:analog_faith/lists/camera_conditions_list.dart';

class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({Key? key}) : super(key: key);

  @override
  _AddCameraScreenState createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
  List<String> cameraBrands = [];
  List<String> cameraModels = [];
  String selectedBrand = ''; // Selected brand value
  String selectedModel = ''; // Selected model value
  DateTime? selectedPurchaseDate; // Store the selected purchase date
  String selectedCondition = CameraConditions.conditions[0];

  // Define controllers for your text fields
  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController purchaseDateController = TextEditingController();
  final TextEditingController pricePaidController = TextEditingController();
  final TextEditingController conditionController = TextEditingController();
  // final TextEditingController filmLoadedController = TextEditingController();
  // final TextEditingController filmLoadDateController = TextEditingController();
  // final TextEditingController averagePriceController = TextEditingController();
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

  Future<void> fetchCameraModels(String brand) async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    final tableName = '${brand.toLowerCase()}_cameras_catalogue'; // Generate the table name
    final models = await db.query(tableName, columns: ['camera_name']);
    final uniqueModels = <String>{}; // Use a set literal to ensure uniqueness

    for (final modelMap in models) {
      final model = modelMap['camera_name'].toString();
      uniqueModels.add(model);
    }

    cameraModels = uniqueModels.toList(); // Convert back to a list

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedPurchaseDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedPurchaseDate) {
      setState(() {
        selectedPurchaseDate = picked;
      });
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                        cameraModels = []; // Clear the previous models when the brand changes
                      });
                      fetchCameraModels(selectedBrand);
                    },
                    decoration: const InputDecoration(labelText: 'Brand'),
                  ),
                DropdownButtonFormField<String>(
                  value: selectedModel.isNotEmpty && cameraModels.contains(selectedModel) ? selectedModel : null,
                  items: cameraModels.map((String model) {
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
                TextField(
                controller: serialNumberController,
                decoration: const InputDecoration(labelText: 'Serial Number'),
                keyboardType: TextInputType.number, // Set the keyboard type to numeric
              ),
                InkWell(
                  onTap: () {
                    _selectDate(context); // Show date picker on tap
                  },
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      labelText: 'Purchase date',
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          selectedPurchaseDate != null
                              ? '${selectedPurchaseDate!.year}-${selectedPurchaseDate!.month.toString().padLeft(2, '0')}-${selectedPurchaseDate!.day.toString().padLeft(2, '0')}'
                              : 'Select a date',
                        ),
                        const Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
                TextField(
                  controller: pricePaidController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d{0,2})?$')),
                  ],
                  decoration: const InputDecoration(
                    labelText: 'Price paid (EUR)',
                    suffixText: 'EUR', // Display EUR as suffix
                  ),
                ),
                DropdownButtonFormField<String>(
                  value: selectedCondition,
                  items: CameraConditions.conditions.map((String condition) {
                    return DropdownMenuItem<String>(
                      value: condition,
                      child: Text(condition),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedCondition = value!;
                    });
                  },
                  decoration: const InputDecoration(labelText: 'Camera Condition'),
                ),
              // TextField(
              //   controller: filmLoadedController,
              //   enabled: false,
              //   decoration: const InputDecoration(labelText: 'Film loaded'),
              // ),
              // TextField(
              //   controller: filmLoadDateController,
              //   enabled: false,
              //   decoration: const InputDecoration(labelText: 'Film load date'),
              // ),
              // TextField(
              //   controller: averagePriceController,
              //   enabled: false,
              //   decoration: const InputDecoration(
              //       labelText: 'Camera average price'),
              // ),
              TextField(
                controller: commentsController,
                maxLength: 200,
                decoration: const InputDecoration(labelText: 'Comments'),
              ),
              // Add more text fields for other camera details
              ElevatedButton(
                onPressed: () {
                  // Retrieve the input values from the text controllers
                  final brand = brandController.text;
                  final model = modelController.text;
                  final serialNumber = serialNumberController.text;
                  final purchaseDate = selectedPurchaseDate != null
                      ? '${selectedPurchaseDate!.year}-${selectedPurchaseDate!.month.toString().padLeft(2, '0')}-${selectedPurchaseDate!.day.toString().padLeft(2, '0')}'
                      : '';
                  final pricePaid = pricePaidController.text;
                  final condition = conditionController.text;
                  // final filmLoaded = filmLoadedController.text;
                  // final filmLoadDate = filmLoadDateController.text;
                  // final averagePrice = averagePriceController.text;
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
