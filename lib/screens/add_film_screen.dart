import 'package:flutter/material.dart';

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
            TextFormField(
              controller: brandController,
              decoration: const InputDecoration(labelText: 'Brand'),
            ),
            TextFormField(
              controller: nameController,
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
