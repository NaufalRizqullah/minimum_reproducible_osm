import 'package:flutter/material.dart';
import 'package:minimum_reproducible_osm/osm/osm.dart';

void main() async {
  runApp(const Run());
}

class Run extends StatelessWidget {
  const Run({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSM',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const OSM(),
    );
  }
}
