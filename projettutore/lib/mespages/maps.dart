
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapspage extends StatefulWidget {
  const Mapspage({super.key});

  @override
  State<Mapspage> createState() => _MapspageState();
}

class _MapspageState extends State<Mapspage> {
  static const LatLng _pGooglePlex =
      LatLng(29.191455839476035, -1.6412661056693805);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: _pGooglePlex, zoom: 13),
      ),
    );
  }
}
