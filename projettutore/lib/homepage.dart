  import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps_flutter;
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart' as google_maps_flutter_web;
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  final String email;
  final String profil;

  Homepage({Key? key, required this.email, required this.profil})
      : super(key: key);

  Future<void> logoutUser(String email, BuildContext context) async {
    final url = 'http://192.168.43.148:81/projetSV/selectUser.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text(
                'Erreur lors de la déconnexion. Veuillez réessayer plus tard.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: MemoryImage(
                  base64Decode(profil),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text(
                'Operateur: $email',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
          Expanded(
            child: google_maps_flutter.GoogleMap(
              initialCameraPosition: const google_maps_flutter.CameraPosition(
                target: google_maps_flutter.LatLng(45.521563, -122.677433),
                zoom: 11.0,
              ),
              onMapCreated:
                  (google_maps_flutter.GoogleMapController controller) {
                // Contrôleur de la carte
              },
            ),
          ),
        ],
      ),
    );
  }
}