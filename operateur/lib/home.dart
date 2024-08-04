import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:operateur/admin/login.dart';
import 'package:operateur/admin/victime.dart';
import 'package:operateur/menu.dart';
import 'package:operateur/mespages/appel.dart';
import 'package:audioplayers/audioplayers.dart';

Future<int> fetchRecordCount() async {
  final url =
      Uri.parse('http://192.168.43.148:81/projetSV/recordstate.php.php');
  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        // Supposons que vous récupérez un seul enregistrement
        return int.parse(data[0]['record_count']);
      }
    }
  } catch (error) {
    print('Erreur lors de la récupération des données: $error');
  }
  return 0; // Retourner 0 si aucune donnée n'est disponible ou en cas d'erreur
}

class Homepage extends StatefulWidget {
  final String email;
  final LatLng? initialLocation;

  Homepage({Key? key, required this.email, this.initialLocation})
      : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int _notificationCount = 0;
  int _recordCount = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  void _checkNotifications() async {
    setState(() {
      _notificationCount = 5;
    });

    if (_notificationCount > 0) {
      // Jouer un son
      await _audioPlayer.play(
        AssetSource('assets/sirene.mp3'),
      );
    }
  }

  Future<void> _loadRecordCount() async {
    final count = await fetchRecordCount();
    setState(() {
      _recordCount = count;
    });
  }

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
    _checkNotifications();
    _loadRecordCount();
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
              title: const Text('Signaux de détresse'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Urgences(),
                ));
              },
              trailing: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Icon(Icons.notifications_active),
                  if (_recordCount > 0)
                    Positioned(
                      right: 0,
                      top: -5,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          minHeight: 20,
                        ),
                        child: Center(
                          child: Text(
                            '$_recordCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
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
              leading: const Icon(
                Icons.support_agent_outlined,
                color: Colors.blue,
              ),
              title: const Text('Agent'),
              onTap: () {
                Navigator.pop(context);
              },
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
              center: _markerLocation ??
                  LatLng(-4.4419,
                      15.2663), // Utiliser l'emplacement du marqueur si disponible
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
