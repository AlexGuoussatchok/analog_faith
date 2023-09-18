import 'package:flutter/material.dart';

class CatalogueScreen extends StatelessWidget {
  const CatalogueScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalogue'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalogue/cameras');
              },
              child: const Text('Cameras'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalogue/lenses');
              },
              child: const Text('Lenses'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalogue/films');
              },
              child: const Text('Films'),
            ),
          ],
        ),
      ),
    );
  }
}
