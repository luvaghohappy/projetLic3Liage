import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

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
                'Erreur de connexion. Veuillez réessayer plus tard.'),
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Welcome $email',
          style: const TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            color: Colors.black,
            icon: const Icon(Icons.logout),
            onPressed: () => logoutUser(email, context),
          ),
        ],
      ),
      body: kIsWeb
          ? const HereMapsWebView()
          : const Center(
              child: Text('Map not supported on this platform'),
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
  InAppWebViewController? _webViewController;

  final String initialHtml = '''
    <!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Operateur App</title>
  <link rel="preload" href="https://js.api.here.com/v3/3.1/styles/fonts/FiraGO-Map.woff" as="font" type="font/woff" crossorigin="anonymous">
  <link rel="preload" href="https://js.api.here.com/v3/3.1/styles/fonts/FiraGO-Italic.woff" as="font" type="font/woff" crossorigin="anonymous">
  <style>
    #mapContainer {
      width: 100vw;
      height: 100vh;
      margin: 0;
      padding: 0;
      display: flex; 
    }
    #searchBar {
      position: absolute;
      top: 10px;
      right: 10px;
      z-index: 1000;
      background: white;
      padding: 10px;
      border-radius: 5px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
      display: flex; 
    }
    #searchInput {
      width: 300px;
      padding: 5px;
    }
    #searchButton {
      padding: 5px;
    }
    #results {
      position: absolute;
      top: 50px;
      right: 10px;
      background: white;
      z-index: 1000;
      padding: 10px;
      border-radius: 5px;
      box-shadow: 0 2px 6px rgba(0,0,0,0.3);
      display: none; /* Masquer les résultats de recherche par défaut */
    }
  </style>
  <script src="https://js.api.here.com/v7/mapsjs.bundle.js"></script>
  <script src="https://js.api.here.com/v3/3.1/mapsjs-core.js"></script>
  <script src="https://js.api.here.com/v3/3.1/mapsjs-service.js"></script>
  <script src="https://js.api.here.com/v3/3.1/mapsjs-ui.js"></script>
  <script src="https://js.api.here.com/v3/3.1/mapsjs-mapevents.js"></script>
  <link rel="stylesheet" type="text/css" href="https://js.api.here.com/v3/3.1/mapsjs-ui.css"/>
  <script>
    var map;

    function initMap() {
      var platform = new H.service.Platform({
        'apikey': '6nIGuVmqqMwOppHrpBSBf6U_muWT0r2bNBbONkEBilM',
        'lang': 'fr-FR'
      });

      var defaultLayers = platform.createDefaultLayers();
      map = new H.Map(
        document.getElementById('mapContainer'),
        defaultLayers.vector.normal.map,
        {
          zoom: 6,
          center: { lat: -2.87, lng: 23.65 }
        }
      );

      var mapEvents = new H.mapevents.MapEvents(map);
      var behavior = new H.mapevents.Behavior(mapEvents);
      var ui = H.ui.UI.createDefault(map, defaultLayers);

      document.getElementById('searchButton').onclick = function() {
        var query = document.getElementById('searchInput').value;
        searchLocation(platform, query, map);
      };

      // Afficher les éléments de la carte après leur initialisation
      document.getElementById('mapContainer').style.display = 'block';
      document.getElementById('searchBar').style.display = 'block';
      document.getElementById('results').style.display = 'block';
    }

    function searchLocation(platform, query, map) {
      var geocodingParams = {
        q: query,
        in: 'countryCode:COD', // Limiter la recherche à la RDC
      };

      var geocoder = platform.getSearchService();
      geocoder.geocode(geocodingParams, (result) => {
        if (result.items.length > 0) {
          var resultsHtml = '<ul>';
          result.items.forEach((item) => {
            resultsHtml += '<li><a href="#" onclick="selectLocation(' + item.position.lat + ',' + item.position.lng + '); return false;">' + item.address.label + '</a></li>';
          });
          resultsHtml += '</ul>';
          document.getElementById('results').innerHTML = resultsHtml;
        } else {
          alert('Location not found!');
        }
      }, (error) => {
        alert('Geocode error: ' + error.message);
        console.error('Geocode error:', error);
      });
    }

    function selectLocation(lat, lng) {
      var position = { lat: lat, lng: lng };
      map.setCenter(position);
      map.setZoom(14);
      var marker = new H.map.Marker(position);
      map.addObject(marker);
    }
  </script>
</head>
<body>
  <div id="searchBar">
    <input type="text" id="searchInput" placeholder="Rechercher un endroit...">
    <button id="searchButton">Rechercher</button>
  </div>
  <div id="results"></div>
  <div id="mapContainer"></div>
  <script src="main.dart.js" type="application/javascript"></script>
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
        setState(() {
          _webViewController = controller;
        });
      },
      onLoadStop: (controller, url) async {
        await controller.evaluateJavascript(source: '''
          if (typeof initMap === 'function') {
            initMap();
          }
        ''');
        setState(() {});
      },
    );
  }
}
