import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: MemoryImage(base64Decode(profil)),
                ),
                const SizedBox(width: 10),
                Text(
                  'Opérateur: $email',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 100),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Appels'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Postes'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('GPS'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 450),
                ),
                TextButton(
                  onPressed: () => logoutUser(email, context),
                  child: const Text('Déconnexion'),
                ),
              ],
            ),
          ),
          const Expanded(
            child: HereMapsWebView(),
          ),
        ],
      ),
    );
  }
}

class HereMapsWebView extends StatefulWidget {
  const HereMapsWebView({Key? key}) : super(key: key);

  @override
  _HereMapsWebViewState createState() => _HereMapsWebViewState();
}

class _HereMapsWebViewState extends State<HereMapsWebView> {
  final String initialHtml = '''
    <!DOCTYPE html>
    <html>
    <head>
      <title>Here Maps Example</title>
      <meta name="viewport" content="initial-scale=1.0, width=device-width" />
      <script src="https://js.api.here.com/v3/3.1/mapsjs-core.js"></script>
      <script src="https://js.api.here.com/v3/3.1/mapsjs-service.js"></script>
      <script src="https://js.api.here.com/v3/3.1/mapsjs-ui.js"></script>
      <script src="https://js.api.here.com/v3/3.1/mapsjs-mapevents.js"></script>
      <link rel="stylesheet" type="text/css" href="https://js.api.here.com/v3/3.1/mapsjs-ui.css"/>
      <style>
        html, body, #mapContainer {
          width: 100%;
          height: 100%;
          margin: 0;
          overflow: hidden;
        }
      </style>
      <script>
        function initMap() {
          var platform = new H.service.Platform({
            'apikey': 'YOUR_API_KEY'
          });
          var defaultLayers = platform.createDefaultLayers();
          var map = new H.Map(
            document.getElementById('mapContainer'),
            defaultLayers.vector.normal.map,
            {
              zoom: 10,
              center: { lat: 52.5, lng: 13.4 }
            }
          );
          var mapEvents = new H.mapevents.MapEvents(map);
          var behavior = new H.mapevents.Behavior(mapEvents);
          var ui = H.ui.UI.createDefault(map, defaultLayers);
        }

        window.onload = initMap;
      </script>
    </head>
    <body>
      <div id="mapContainer"></div>
    </body>
    </html>
  ''';

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      initialData: InAppWebViewInitialData(
        data: initialHtml,
        baseUrl: WebUri('about:blank'),
        encoding: 'utf-8',
        mimeType: 'text/html',
      ),
      onLoadStart: (controller, url) {
        setState(() {});
      },
      onLoadStop: (controller, url) async {
        setState(() {});
      },
    );
  }
}
