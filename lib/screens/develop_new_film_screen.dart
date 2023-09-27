import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  DateTime selectedDate = DateTime.now();
  List<String> filmNames = [];
  String selectedFilm = '';
  DateTime? selectedShootingStartDate = DateTime.now();
  DateTime? selectedShootingEndDate = DateTime.now();


  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    )) ?? DateTime.now(); // Provide a default value if picked is null
    setState(() {
      selectedDate = picked;
      dateController.text = DateFormat('yyyy-MM-dd').format(picked);
    });
  }

  Future<void> _selectShootingStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedShootingStartDate ?? DateTime.now(), // Provide a default value if it's null
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedShootingStartDate = picked;
        filmShootingStartDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectShootingEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedShootingEndDate ?? DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedShootingEndDate = picked;
        filmShootingEndDateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }


  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);

    // When the screen is opened, check the database for the highest film_number.
    _getHighestFilmNumber();
    getFilmNamesFromDatabase().then((names) {
      setState(() {
        filmNames = names;
        if (filmNames.isNotEmpty) {
          selectedFilm = filmNames[0]; // Set the default selected film
        }
      });
    });
    filmShootingStartDateController.text = DateFormat('yyyy-MM-dd').format(selectedShootingStartDate ?? DateTime.now());

  }

  Future<void> _getHighestFilmNumber() async {
    // Open the darkroom_notes database.
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'darkroom_notes.db'),
      version: 1,
    );

    // Query the database to get the highest film_number.
    final results = await database.rawQuery('SELECT MAX(film_number) as max_number FROM film_developing_notes');
    final maxNumber = results.first['max_number'] as int? ?? 0;

    // Set the initial value of the filmNumberController to maxNumber + 1.
    filmNumberController.text = (maxNumber + 1).toString();
  }

  Future<List<String>> getFilmNamesFromDatabase() async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'inventory.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> maps = await database.query('my_films');
    final List<String> filmNames = List.generate(maps.length, (index) {
      return '${maps[index]['brand']} ${maps[index]['film_name']}';
    });

    return filmNames;
  }

  Future<void> updateISOShutterFromDatabase(String selectedFilm) async {
    final databasePath = await getDatabasesPath();
    final database = await openDatabase(
      join(databasePath, 'inventory.db'),
      version: 1,
    );

    final List<Map<String, dynamic>> maps = await database.query('my_films',
        where: 'brand || " " || film_name = ?',
        whereArgs: [selectedFilm]);

    if (maps.isNotEmpty) {
      final isoShutterValue = maps[0]['film_iso'];
      isoShutController.text = isoShutterValue.toString();
    } else {
      isoShutController.text = ''; // Set to empty if film not found
    }
  }


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
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: 'Date'),
                  ),
                ),
              ),

              TextFormField(
                controller: filmNumberController,
                decoration: const InputDecoration(labelText: 'Film Number'),
                keyboardType: TextInputType.number,
              ),

              DropdownButtonFormField<String>(
                value: selectedFilm,
                onChanged: (newValue) {
                  setState(() {
                    selectedFilm = newValue!;
                    // Update isoShutController based on the selected film
                    updateISOShutterFromDatabase(selectedFilm);
                  });
                },
                items: filmNames.map((film) {
                  return DropdownMenuItem<String>(
                    value: film,
                    child: Text(film),
                  );
                }).toList(),
                decoration: const InputDecoration(labelText: 'Film'),
              ),


              GestureDetector(
                onTap: () => _selectShootingStartDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: filmShootingStartDateController,
                    decoration: const InputDecoration(labelText: 'Film Shooting Start Date'),
                  ),
                ),
              ),

              GestureDetector(
                onTap: () => _selectShootingEndDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: filmShootingEndDateController,
                    decoration: const InputDecoration(labelText: 'Film Shooting End Date'),
                  ),
                ),
              ),

              TextFormField(
                controller: isoShutController,
                decoration: const InputDecoration(labelText: 'ISO shut'),
                keyboardType: TextInputType.number,
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
