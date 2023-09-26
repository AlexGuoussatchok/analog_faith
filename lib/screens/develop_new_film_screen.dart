import 'package:flutter/material.dart';

class DevelopNewFilmScreen extends StatefulWidget {
  const DevelopNewFilmScreen({Key? key}) : super(key: key);

  @override
  _DevelopNewFilmScreenState createState() => _DevelopNewFilmScreenState();
}

class _DevelopNewFilmScreenState extends State<DevelopNewFilmScreen> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController filmNumberController = TextEditingController();
  final TextEditingController filmController = TextEditingController();
  final TextEditingController filmShootingStartDateController = TextEditingController();
  final TextEditingController filmShootingEndDateController = TextEditingController();
  final TextEditingController isoShutController = TextEditingController();
  final TextEditingController filmTypeController = TextEditingController();
  final TextEditingController filmSizeController = TextEditingController();
  final TextEditingController filmExpiredController = TextEditingController();
  final TextEditingController filmExpirationDateController = TextEditingController();
  final TextEditingController cameraController = TextEditingController();
  final TextEditingController lensesController = TextEditingController();
  final TextEditingController developerController = TextEditingController();
  final TextEditingController labController = TextEditingController();
  final TextEditingController dilutionController = TextEditingController();
  final TextEditingController developingTimeController = TextEditingController();
  final TextEditingController temperatureController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Develop New Film'),
        backgroundColor: Colors.grey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: dateController,
                decoration: const InputDecoration(labelText: 'Date'),
              ),
              TextFormField(
                controller: filmNumberController,
                decoration: const InputDecoration(labelText: 'Film Number'),
              ),
              TextFormField(
                controller: filmController,
                decoration: const InputDecoration(labelText: 'Film'),
              ),
              TextFormField(
                controller: filmShootingStartDateController,
                decoration: const InputDecoration(labelText: 'Film Shooting Start Date'),
              ),
              TextFormField(
                controller: filmShootingEndDateController,
                decoration: const InputDecoration(labelText: 'Film Shooting End Date'),
              ),
              TextFormField(
                controller: isoShutController,
                decoration: const InputDecoration(labelText: 'ISO/Shutter Speed'),
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
                controller: filmExpiredController,
                decoration: const InputDecoration(labelText: 'Film Expired (1 for Yes, 0 for No)'),
              ),
              TextFormField(
                controller: filmExpirationDateController,
                decoration: const InputDecoration(labelText: 'Film Expiration Date'),
              ),
              TextFormField(
                controller: cameraController,
                decoration: const InputDecoration(labelText: 'Camera'),
              ),
              TextFormField(
                controller: lensesController,
                decoration: const InputDecoration(labelText: 'Lenses'),
              ),
              TextFormField(
                controller: developerController,
                decoration: const InputDecoration(labelText: 'Developer'),
              ),
              TextFormField(
                controller: labController,
                decoration: const InputDecoration(labelText: 'Lab'),
              ),
              TextFormField(
                controller: dilutionController,
                decoration: const InputDecoration(labelText: 'Dilution'),
              ),
              TextFormField(
                controller: developingTimeController,
                decoration: const InputDecoration(labelText: 'Developing Time'),
              ),
              TextFormField(
                controller: temperatureController,
                decoration: const InputDecoration(labelText: 'Temperature'),
              ),
              TextFormField(
                controller: commentsController,
                decoration: const InputDecoration(labelText: 'Comments'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add functionality to save film development data
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
    // Dispose of the controllers when the widget is removed from the tree
    dateController.dispose();
    filmNumberController.dispose();
    filmController.dispose();
    filmShootingStartDateController.dispose();
    filmShootingEndDateController.dispose();
    isoShutController.dispose();
    filmTypeController.dispose();
    filmSizeController.dispose();
    filmExpiredController.dispose();
    filmExpirationDateController.dispose();
    cameraController.dispose();
    lensesController.dispose();
    developerController.dispose();
    labController.dispose();
    dilutionController.dispose();
    developingTimeController.dispose();
    temperatureController.dispose();
    commentsController.dispose();
    super.dispose();
  }
}