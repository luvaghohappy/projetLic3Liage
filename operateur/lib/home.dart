import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:operateur/admin/login.dart';
import 'package:operateur/admin/victime.dart';
import 'package:operateur/menu.dart';
import 'package:operateur/mespages/agent.dart';
import 'package:operateur/mespages/appel.dart';

class Homepage extends StatefulWidget {
  final String email;
  final LatLng? initialLocation;

  const Homepage({Key? key, required this.email, this.initialLocation})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _notificationCount = 0;
  int _recordCount = 0;
  final TextEditingController _searchController = TextEditingController();
  final MapController _mapController = MapController();
  double _currentZoom = 13.0;
  LatLng? _markerLocation;

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
  void initState() {
    super.initState();
    if (widget.initialLocation != null) {
      _markerLocation = widget.initialLocation;
      Future.microtask(() {
        _mapController.move(_markerLocation!, _currentZoom);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: const [
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('assets/logo.jpg'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            Text(
              'VIE_SAUVE',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const Menu(),
              ));
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
                width: 250,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              leading: const Icon(
                Icons.location_pin,
                color: Color.fromARGB(255, 190, 117, 20),
              ),
              title: const Text('Signales des détresses'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Urgences(),
                ));
              },
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Utilisateurs(),
                ));
              },
              leading: const Icon(
                Icons.person_2_outlined,
                color: Colors.yellowAccent,
              ),
              title: const Text('Utilisateurs'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Agents(),
                ));
              },
              leading: const Icon(
                Icons.support_agent_outlined,
                color: Colors.blue,
              ),
              title: const Text('Postes'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 200),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.admin_panel_settings,
                color: Colors.red,
              ),
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
              center: _markerLocation ?? LatLng(-4.4419, 15.2663),
              zoom: _currentZoom,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.app',
              ),
              if (_markerLocation != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      point: _markerLocation!,
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
