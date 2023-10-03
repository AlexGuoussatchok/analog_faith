import 'package:flutter/material.dart';

class LoadFilmScreen extends StatelessWidget {
  final Map<String, dynamic> cameraData;

  const LoadFilmScreen({Key? key, required this.cameraData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Implement your load film screen logic here
    return Scaffold(
      appBar: AppBar(
        title: const Text('Load Film'),
        backgroundColor: Colors.grey,
      ),
      body: const Center(
        child: Text('Load Film Screen'),
      ),
    );
  }
}





