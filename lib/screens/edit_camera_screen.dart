import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';

class EditCameraScreen extends StatefulWidget {
  final Map<String, dynamic> cameraData;

  const EditCameraScreen({Key? key, required this.cameraData}) : super(key: key);

  @override
  _EditCameraScreenState createState() => _EditCameraScreenState();
}

class _EditCameraScreenState extends State<EditCameraScreen> {
  late TextEditingController brandController;
  late TextEditingController modelController;
  late TextEditingController serialNumberController;
  late TextEditingController purchaseDateController;
  late TextEditingController pricePaidController;
  late TextEditingController conditionController;
  late TextEditingController commentsController;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with the existing camera data
    brandController = TextEditingController(text: widget.cameraData['brand']);
    modelController = TextEditingController(text: widget.cameraData['model']);
    serialNumberController = TextEditingController(text: widget.cameraData['serial_number']);
    purchaseDateController = TextEditingController(text: widget.cameraData['purchase_date']);
    pricePaidController = TextEditingController(text: widget.cameraData['price_paid'].toString());
    conditionController = TextEditingController(text: widget.cameraData['condition']);
    commentsController = TextEditingController(text: widget.cameraData['comments']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Camera'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: brandController,
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
                decoration: const InputDecoration(labelText: 'Purchase Date'),
              ),
              TextField(
                controller: pricePaidController,
                decoration: const InputDecoration(labelText: 'Price Paid (EUR)'),
              ),
              TextField(
                controller: conditionController,
                decoration: const InputDecoration(labelText: 'Condition'),
              ),
              TextField(
                controller: commentsController,
                decoration: const InputDecoration(labelText: 'Comments'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Retrieve the modified values from the text controllers
                  final brand = brandController.text;
                  final model = modelController.text;
                  final serialNumber = serialNumberController.text;
                  final purchaseDate = purchaseDateController.text;
                  final pricePaid = double.tryParse(pricePaidController.text) ?? 0.0;
                  final condition = conditionController.text;
                  final comments = commentsController.text;

                  // Update the existing camera record in the database
                  await InventoryDatabaseHelper().updateCamera(
                    widget.cameraData['id'], // Provide the camera ID to identify the record
                    brand,
                    model,
                    serialNumber,
                    purchaseDate,
                    pricePaid,
                    condition,
                    comments,
                  );

                  Navigator.pop(context);
                },
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
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
