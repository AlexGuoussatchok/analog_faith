import 'package:flutter/material.dart';
import 'package:analog_faith/database_helper/inventory_database_helper.dart';
import 'package:analog_faith/screens/my_cameras_details_screen.dart';
import 'package:pdf/widgets.dart' as pdfwidgets;
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyCamerasScreen extends StatefulWidget {
  const MyCamerasScreen({Key? key}) : super(key: key);

  @override
  _MyCamerasScreenState createState() => _MyCamerasScreenState();
}

class _MyCamerasScreenState extends State<MyCamerasScreen> {
  final InventoryDatabaseHelper databaseHelper = InventoryDatabaseHelper();
  late Directory? _saveDirectory; // Directory to save the PDF
  late List<Map<String, dynamic>> camerasList; // Declare camerasList

  @override
  void initState() {
    super.initState();
    _initializeSaveDirectory();
    _fetchCamerasData(); // Fetch camera data when the screen initializes
  }

  Future<void> _initializeSaveDirectory() async {
    _saveDirectory = await getApplicationDocumentsDirectory();
  }

  Future<void> _fetchCamerasData() async {
    final data = await databaseHelper.getMyCameras();
    setState(() {
      camerasList = data;
    });
  }

  Future<void> generateAndSavePDF(List<Map<String, dynamic>> camerasData) async {
    final pdf = pdfwidgets.Document();

    pdf.addPage(
      pdfwidgets.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,

        build: (context) => [
          pdfwidgets.TableHelper.fromTextArray(
            headers: ['Brand', 'Model', 'Serial Number', 'Purchase Date', 'Price Paid', 'Condition', 'Comments'],
            data: camerasData.map((camera) => [
              camera['brand'],
              camera['model'],
              camera['serial_number'],
              camera['purchase_date'],
              camera['price_paid'].toString(),
              camera['condition'],
              camera['comments'],
            ]).toList(),
          ),
        ],
      ),
    );

    final path = '${_saveDirectory?.path ?? ''}/my_cameras.pdf';

    try {
      final file = File(path);
      await file.writeAsBytes(await pdf.save());

    } catch (e) {

    }
  }


  Future<void> chooseSaveDirectory() async {
    final result = await FilePicker.platform.getDirectoryPath();
    if (result != null) {
      setState(() {
        _saveDirectory = Directory(result);
      });
      generateAndSavePDF(camerasList); // Call the PDF generation method with your data
    }
  }

  Future<void> checkAndRequestStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // Handle the scenario when the permission is denied
        return;
      }
    }

    // Now you have the permission, proceed with your file operations
    // ... your code to read/write to storage
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cameras'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'add_camera') {
                // Handle the "Add a Camera" option here, navigate to the add camera screen.
                Navigator.pushNamed(context, '/inventory/add_camera');
              } else if (value == 'save_as_pdf') {
                checkAndRequestStoragePermission().then((_) {
                  chooseSaveDirectory();
                });
              }
            },

            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'add_camera',
                  child: Text('Add a Camera'),
                ),
                const PopupMenuItem<String>(
                  value: 'save_as_pdf',
                  child: Text('Save as PDF'),
                ),
                // Add more menu items if needed
              ];
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        // Use the database helper to fetch the camera inventory
        future: databaseHelper.getMyCameras(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
            return const Center(child: Text('No cameras in inventory.'));
          } else {
            final camerasList = snapshot.data as List<Map<String, dynamic>>;
            return ListView.builder(
              itemCount: camerasList.length,
              itemBuilder: (context, index) {
                final camera = camerasList[index];
                return InkWell(
                  onTap: () {
                    // Navigate to MyCamerasDetailsScreen and pass camera data
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyCamerasDetailsScreen(
                          cameraData: camera,
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(camera['brand'] + ' ' + camera['model']),
                    subtitle: Text('Serial Number: ${camera['serial_number']}'),
                    // You can display more camera details here as needed
                    // Add edit and delete functionality if required
                  ),
                );
              },
            );
          }
        },
      ),

    );
  }
}

