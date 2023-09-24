import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:analog_faith/lists/film_sizes.dart';

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
  TextEditingController expirationDateController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController pricePaidController = TextEditingController();
  TextEditingController commentsController = TextEditingController();

  List<String> brandList = [];
  List<String> filmNameList = [];

  String? selectedBrand;
  String? selectedFilmName;
  String? selectedFilmType;
  String? selectedFilmSize;
  bool? isFilmExpired;


  @override
  void initState() {
    super.initState();
    // Load the brands from the database when the screen initializes
    fetchBrands();

    // Set the initial value for brandController if brandList is not empty
    if (brandList.isNotEmpty) {
      brandController.text = brandList.first;
    }

    // Initialize the filmTypeController with the selectedFilmType
    filmTypeController.text = selectedFilmType ?? '';
    isFilmExpired = false;
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

  Future<void> fetchFilmType(String? selectedBrand, String? selectedFilmName) async {
    if (selectedBrand == null || selectedFilmName == null) {
      return;
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    // Construct the table name dynamically.
    final tableName = '${selectedBrand.toLowerCase()}_films_catalogue';

    final filmTypeQuery = await db.query(
      tableName,
      columns: ['film_type'],
      where: 'film_name = ?',
      whereArgs: [selectedFilmName],
    );

    if (filmTypeQuery.isNotEmpty) {
      final filmType = filmTypeQuery.first['film_type'].toString();
      setState(() {
        filmTypeController.text = filmType;
      });
    }
  }

  Future<void> fetchISO(String? selectedBrand, String? selectedFilmName) async {
    if (selectedBrand == null || selectedFilmName == null) {
      return;
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final db = await openDatabase(path);

    // Construct the table name dynamically.
    final tableName = '${selectedBrand.toLowerCase()}_films_catalogue';

    final isoQuery = await db.query(
      tableName,
      columns: ['film_speed'],
      where: 'film_name = ?',
      whereArgs: [selectedFilmName],
    );

    if (isoQuery.isNotEmpty) {
      final isoValue = isoQuery.first['film_speed'].toString();
      setState(() {
        isoController.text = isoValue;
      });
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
              value: selectedBrand,
              items: brandList.map((String brand) {
                return DropdownMenuItem<String>(
                  value: brand,
                  child: Text(brand),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedBrand = value;

                  // Reset film name and type when the brand changes
                  selectedFilmName = null;
                  selectedFilmType = null;
                  filmTypeController.text = '';
                  isoController.text = '';
                  framesNumberController.text = '';
                  expirationDateController.text = '';

                  // Fetch film names based on the selected brand.
                  fetchFilmNames(value ?? '');
                });
              },
              decoration: const InputDecoration(labelText: 'Brand'),
            ),


            DropdownButtonFormField<String>(
              value: selectedFilmName,
              items: filmNameList.map((String filmName) {
                return DropdownMenuItem<String>(
                  value: filmName,
                  child: Text(filmName),
                );
              }).toList(),
              onChanged: (String? value) async {
                setState(() {
                  selectedFilmName = value;

                  // Fetch film type based on the selected brand and film name.
                  fetchFilmType(selectedBrand, value);

                  // Fetch ISO based on the selected film name.
                  fetchISO(selectedBrand, value);
                });
              },
              decoration: const InputDecoration(labelText: 'Film Name'),
            ),

            TextFormField(
              controller: filmTypeController,
              decoration: const InputDecoration(labelText: 'Film Type'),
            ),

            DropdownButtonFormField<String>(
              value: selectedFilmSize,
              items: FilmSizesList.conditions.map((String size) {
                return DropdownMenuItem<String>(
                  value: size,
                  child: Text(size),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedFilmSize = value;

                  // Set the default frame number based on the selected film size
                  framesNumberController.text = FilmSizesList.defaultFrameNumbers[value ?? ''].toString();
                });
              },
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

            Row(
              children: <Widget>[
                const Text('Is Film Expired:'),
                const SizedBox(width: 16.0), // Add spacing between label and radio buttons
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Radio<bool>(
                        value: true,
                        groupValue: isFilmExpired,
                        onChanged: (bool? value) {
                          setState(() {
                            isFilmExpired = value ?? false;
                          });
                        },
                      ),
                      const Text('Expired'),
                      Radio<bool>(
                        value: false,
                        groupValue: isFilmExpired,
                        onChanged: (bool? value) {
                          setState(() {
                            isFilmExpired = value ?? false;
                          });
                        },
                      ),
                      const Text('Not Expired'),
                    ],
                  ),
                ),
              ],
            ),

            TextFormField(
              controller: expirationDateController,
              decoration: const InputDecoration(labelText: 'Film Expiration date'),
              onTap: () async {
                final DateTime currentDate = DateTime.now();
                DateTime selectedDate = currentDate;

                final BuildContext dialogContext = context; // Capture the context

                final year = await showDialog<int>(
                  context: dialogContext, // Use the captured context
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Year'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          itemCount: currentDate.year - 1964, // Minimum year is 1965
                          itemBuilder: (BuildContext context, int index) {
                            final int year = currentDate.year - index;
                            return ListTile(
                              title: Text(year.toString()),
                              onTap: () {
                                selectedDate = DateTime(year, currentDate.month);
                                Navigator.of(context).pop(year);
                              },
                            );
                          },
                        ),
                      ),
                    );
                  },
                );

                if (year != null) {
                  final month = await showDialog<int>(
                    context: dialogContext, // Use the captured context
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Select Month'),
                        content: SizedBox(
                          width: double.maxFinite,
                          child: ListView.builder(
                            itemCount: 12, // 12 months
                            itemBuilder: (BuildContext context, int index) {
                              final int month = index + 1;
                              return ListTile(
                                title: Text(month.toString()),
                                onTap: () {
                                  selectedDate = DateTime(selectedDate.year, month);
                                  Navigator.of(context).pop(month);
                                },
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );

                  if (month != null) {
                    final String formattedDate = '${selectedDate.year}-${month.toString().padLeft(2, '0')}';
                    setState(() {
                      expirationDateController.text = formattedDate;
                    });
                  }
                }
              },
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
    expirationDateController.dispose();
    quantityController.dispose();
    pricePaidController.dispose();
    commentsController.dispose();
    super.dispose();
  }
}
