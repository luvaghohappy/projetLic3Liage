import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class Agents extends StatefulWidget {
  const Agents({super.key});

  @override
  State<Agents> createState() => _AgentsState();
}

class _AgentsState extends State<Agents> {
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;
  LatLng? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _listenToLocationChanges();
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
    _mapController.move(_currentLocation!, _currentZoom);
  }

  void _listenToLocationChanges() {
    Geolocator.getPositionStream(
            locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.high, distanceFilter: 10))
        .listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
      });
      _mapController.move(_currentLocation!, _currentZoom);
    });
  }

  Future<void> _searchLocation(String query) async {
    final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?q=$query,+RDC&format=json&limit=1');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List results = json.decode(response.body);
        if (results.isNotEmpty) {
          final LatLng location = LatLng(
            double.parse(results[0]['lat']),
            double.parse(results[0]['lon']),
          );

          setState(() {
            _currentLocation = location;
          });
          Future.microtask(() {
            _mapController.move(location, _currentZoom);
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Lieu non trouvé.')),
          );
        }
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de requête: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Agent disponible',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _currentLocation ?? LatLng(-4.4419, 15.2663),
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              if (_currentLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _currentLocation!,
                      builder: (context) => const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 350,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Rechercher...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: const Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.black,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: (value) {
                  if (value.isNotEmpty) {
                    _searchLocation(value);
                  }
                },
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _currentZoom++;
                      Future.microtask(() {
                        _mapController.move(
                            _mapController.center, _currentZoom);
                      });
                    });
                  },
                  child: const Icon(Icons.zoom_in),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      _currentZoom--;
                      Future.microtask(() {
                        _mapController.move(
                            _mapController.center, _currentZoom);
                      });
                    });
                  },
                  child: const Icon(Icons.zoom_out),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
