import 'package:flutter/material.dart';
import 'package:minimum_reproducible_osm/osm/osm.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("OSM - Page 2"),
        backgroundColor: Colors.amber[700],
        leading: IconButton(
          icon: const Icon(Icons.arrow_circle_left_sharp),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OSM()),
            );
          },
        ),
      ),
      body: const Center(
        child: Text("Second Page"),
      ),
    );
  }
}
