import 'package:flutter/material.dart';

class MyCamerasDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> cameraData;

  const MyCamerasDetailsScreen({Key? key, required this.cameraData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera Details'),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Brand: ${cameraData['brand']}',
            style: const TextStyle(fontSize: 30),
            ),
            Text('Model: ${cameraData['model']}',
              style: const TextStyle(fontSize: 30),
            ),
            Text('Serial Number: ${cameraData['serial_number']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Purchase date: ${cameraData['purchase_date']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Price paid: ${cameraData['price_paid']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Condition: ${cameraData['condition']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Film loaded: ${cameraData['film_loaded']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Film load date: ${cameraData['film_load_date']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Average recent price: ${cameraData['average_price']}',
              style: const TextStyle(fontSize: 25),
            ),
            Text('Comments: ${cameraData['comments']}',
              style: const TextStyle(fontSize: 25),
            ),

            // Display more camera details as needed
          ],
        ),
      ),
    );
  }
}
