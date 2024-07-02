import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'dart:js' as js;
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
                backgroundImage: MemoryImage(base64Decode(profil)),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Text(
                'Operateur: $email',
                style: const TextStyle(fontSize: 18, color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 30),
              ),
            ],
          ),
          Expanded(
            child: ArcGISMap(),
          ),
        ],
      ),
    );
  }
}

class ArcGISMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initializeArcGISMap(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
                  'Erreur lors de l\'initialisation de la carte : ${snapshot.error}'));
        } else {
          return const HtmlElementView(viewType: 'viewDiv');
        }
      },
    );
  }

  Future<void> _initializeArcGISMap() async {
    try {
      await html.window.onLoad.first;
      print('Document loaded');
      await js.context.callMethod('require', [
        ['esri/Map', 'esri/views/MapView'],
        (Map, MapView) {
          var map = js.JsObject(Map, [
            js.JsObject.jsify({'basemap': 'streets'})
          ]);
          var view = js.JsObject(MapView, [
            js.JsObject.jsify({
              'container': 'viewDiv',
              'map': map,
              'zoom': 4,
              'center': js.JsArray.from([15, 65])
            })
          ]);
          print('Map initialized');
        }
      ]);
    } catch (e) {
      print('Erreur lors de l\'initialisation de la carte : $e');
      throw 'Erreur lors de l\'initialisation de la carte : $e';
    }
  }
}
