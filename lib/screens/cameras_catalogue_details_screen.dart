import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CameraCatalogueDetailsScreen extends StatefulWidget {
  final String brand;
  final String model;

  const CameraCatalogueDetailsScreen({
    Key? key,
    required this.brand,
    required this.model,
  }) : super(key: key);

  @override
  _CameraCatalogueDetailsScreenState createState() =>
      _CameraCatalogueDetailsScreenState();
}

class _CameraCatalogueDetailsScreenState
    extends State<CameraCatalogueDetailsScreen> {
  late Map<String, dynamic> cameraDetails = {}; // Initialize with an empty map

  @override
  void initState() {
    super.initState();
    fetchCameraDetails();
  }

  Future<void> fetchCameraDetails() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'catalogue.db');
    final database = await openDatabase(path, readOnly: true);

    final tableName = '${widget.brand.toLowerCase()}_cameras_catalogue';
    final result = await database.rawQuery('''
      SELECT camera_name, camera_class, camera_series, mount, frame_size
      FROM $tableName
      WHERE camera_name = ?
    ''', [widget.model]);

    if (result.isNotEmpty) {
      cameraDetails = result.first;
    } else {
      // Handle the case where no details are found.
      cameraDetails = {};
    }

    await database.close();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.brand} ${widget.model}'),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (cameraDetails.isNotEmpty)
              Text('Camera Class: ${cameraDetails['camera_class']}'),
            if (cameraDetails.isNotEmpty)
              Text('Camera Series: ${cameraDetails['camera_series']}'),
            if (cameraDetails.isNotEmpty)
              Text('Mount: ${cameraDetails['mount']}'),
            if (cameraDetails.isNotEmpty)
              Text('Frame Size: ${cameraDetails['frame_size']}'),
          ],
        ),
      ),
    );
  }
}
