import 'package:flutter/material.dart';
import 'package:minimum_reproducible_osm/osm/maps.dart';
import 'package:minimum_reproducible_osm/osm/page2.dart';

class OSM extends StatefulWidget {
  const OSM({super.key});

  @override
  State<OSM> createState() => _OSMState();
}

class _OSMState extends State<OSM> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("OSM - Page 1"),
          backgroundColor: Colors.amber[700],
          actions: [
            IconButton(
              icon: const Icon(Icons.arrow_circle_right_sharp),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondRoute()),
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            // 1. OSM Section
            const Expanded(child: OsmMaps()),

            // 2. Navigation Section
            Container(
              color: Colors.white60,
              height: 120,
              child: const Center(
                child: Text('Bottom Sheet (Plan). Location:'),
              ),
            ),
          ],
        ));
  }
}
