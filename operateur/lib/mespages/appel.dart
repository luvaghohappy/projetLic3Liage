import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:operateur/home.dart';

class Urgences extends StatefulWidget {
  const Urgences({super.key});

  @override
  State<Urgences> createState() => _UrgencesState();
}

class _UrgencesState extends State<Urgences> {
  Map<int, bool> successStatus = {};
  Map<int, bool> failureStatus = {};
  List<Map<String, dynamic>> items = [];
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.148:81/projetSV/get_data.php"),
      );
      if (response.statusCode == 200) {
        setState(() {
          items = List<Map<String, dynamic>>.from(json.decode(response.body));
          // Initialiser les états des cases à cocher
          successStatus = Map.fromIterable(
            List.generate(items.length, (index) => index),
            key: (item) => item,
            value: (item) => false, // Par défaut, non cochée
          );
          failureStatus = Map.fromIterable(
            List.generate(items.length, (index) => index),
            key: (item) => item,
            value: (item) => false, // Par défaut, non cochée
          );
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load items'),
        ),
      );
    }
  }

  void _onStatusChanged(int index, bool isSuccess) {
    setState(() {
      if (isSuccess) {
        successStatus[index] = true;
        failureStatus[index] = false;
      } else {
        successStatus[index] = false;
        failureStatus[index] = true;
      }
    });
  }

  DataCell _buildStatusCell(int index) {
    return DataCell(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Case à cocher pour Succès
          Checkbox(
            value: successStatus[index] ?? false,
            onChanged: (value) {
              _onStatusChanged(index, value ?? false);
            },
            activeColor: Colors.green,
            checkColor: Colors.white,
          ),
          const SizedBox(width: 10),
          // Case à cocher pour Échec
          Checkbox(
            value: failureStatus[index] ?? false,
            onChanged: (value) {
              _onStatusChanged(index, !(value ?? false));
            },
            activeColor: Colors.red,
            checkColor: Colors.white,
          ),
        ],
      ),
    );
  }

  // Fonction pour déplacer la carte vers les coordonnées cliquées
  void _moveToLocation(String location, String service) {
    if (location != null && location.isNotEmpty) {
      try {
        final coordinates =
            location.replaceAll('POINT(', '').replaceAll(')', '').split(' ');
        final lat = double.parse(coordinates[1]);
        final lon = double.parse(coordinates[0]);

        // Assurez-vous que la carte est prête avant de la déplacer
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Déplacer la carte
          _mapController.move(LatLng(lat, lon), 13.0);
        });

        // Naviguer vers la page Homepage
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Homepage(
              email: '', // Passer les paramètres nécessaires
              // profil: service,
              initialLocation:
                  LatLng(lat, lon), // Passer les coordonnées initiales
            ),
          ),
        );
      } catch (e) {
        print('Error parsing location: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Invalid location format'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signaux de détresse'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nom')),
                  DataColumn(label: Text('Postnom')),
                  DataColumn(label: Text('Prenom')),
                  DataColumn(label: Text('Sexe')),
                  DataColumn(label: Text('Locations')),
                  DataColumn(label: Text('Date_Heure')),
                  DataColumn(label: Text('Services')),
                  DataColumn(label: Text('Etat')),
                ],
                rows: List.generate(items.length, (index) {
                  final item = items[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(item['nom'] ?? '')),
                      DataCell(Text(item['postnom'] ?? '')),
                      DataCell(Text(item['prenom'] ?? '')),
                      DataCell(Text(item['sexe'] ?? '')),
                      DataCell(
                        InkWell(
                          onTap: () {
                            _moveToLocation(item['locations'], item['service']);
                          },
                          child: Text(item['locations'] ?? ''),
                        ),
                      ),
                      DataCell(Text(item['created_at'] ?? '')),
                      DataCell(Text(item['service'] ?? '')),
                      _buildStatusCell(index), // Ajouter les cases à cocher
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
