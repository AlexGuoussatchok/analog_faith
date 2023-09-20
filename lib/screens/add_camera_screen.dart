import 'package:flutter/material.dart';

class AddCameraScreen extends StatefulWidget {
  const AddCameraScreen({super.key});

  @override
  _AddCameraScreenState createState() => _AddCameraScreenState();
}

class _AddCameraScreenState extends State<AddCameraScreen> {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
                decoration: const InputDecoration(labelText: 'Purchase date'),
              ),
              TextField(
                controller: pricePaidController,
                decoration: const InputDecoration(labelText: 'Price paid'),
              ),
              TextField(
                controller: conditionController,
                decoration: const InputDecoration(labelText: 'Camera condition'),
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
                decoration: const InputDecoration(labelText: 'Camera average price'),
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
    );
  }

  @override
  void dispose() {
    // Dispose of the text controllers to avoid memory leaks
    brandController.dispose();
    modelController.dispose();
    serialNumberController.dispose();
    purchaseDateController.dispose();
    pricePaidController.dispose();
    conditionController.dispose();
    filmLoadedController.dispose();
    filmLoadDateController.dispose();
    averagePriceController.dispose();
    commentsController.dispose();
    // Dispose of other controllers similarly
    super.dispose();
  }
}
