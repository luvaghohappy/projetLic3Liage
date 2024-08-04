import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:operateur/admin/login.dart';
import 'package:operateur/mespages/appel.dart'; // Assurez-vous que ce fichier est importé

class Homepage extends StatefulWidget {
  final String email;
  final String profil;
  final LatLng?
      initialLocation; // Ajouter une propriété pour les coordonnées initiales

  Homepage(
      {Key? key,
      required this.email,
      required this.profil,
      this.initialLocation})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;
  TextEditingController _searchController = TextEditingController();
  LatLng? _markerLocation; // Variable pour stocker l'emplacement du marqueur

  @override
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _markerLocation = widget.initialLocation;
      // Déplacer la carte à l'initialisation
      Future.microtask(() {
        _mapController.move(_markerLocation!, _currentZoom);
      });
    }
  }

  // Fonction pour rechercher un lieu en RDC
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

          // Déplacer la carte à la nouvelle localisation
          setState(() {
            _markerLocation = location;
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
        title: Row(
          children: [
            Image.asset(
              'assets/logo.jpg',
              height: 40,
              width: 60,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            const Text(
              'VIE_SAUVE',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              // logoutUser(widget.email, context);
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/logo.jpg',
                height: 100,
                width: 180,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Accueil'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Signaux de detresse'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Urgences(),
                ));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Agent'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 200),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Admin x'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LoginAdmin(),
                ));
              },
            ),
            const Divider(),
          ],
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              center: _markerLocation ??
                  LatLng(-4.4419,
                      15.2663), // Utiliser l'emplacement du marqueur si disponible
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              if (_markerLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _markerLocation!,
                      builder: (context) => Container(
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 40,
                        ),
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
