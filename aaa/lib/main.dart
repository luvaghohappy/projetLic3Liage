import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Here Maps in Flutter Web'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: const HereMapsWebView(),
      ),
      debugShowCheckedModeBanner: false,
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
      <script src="https://js.api.here.com/v7/mapsjs.bundle.js"></script>
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
        var map;

        function initMap() {
          var platform = new H.service.Platform({
            'apikey': '6nIGuVmqqMwOppHrpBSBf6U_muWT0r2bNBbONkEBilM'
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
        }

        function searchLocation(platform, query, map) {
          var geocodingParams = {
            q: query,
            in: 'countryCode:COD', // Limiter la recherche à la RDC
            maxresults: 5,
          };

          var geocoder = platform.getSearchService();
          geocoder.geocode(geocodingParams, (result) => {
            if (result.items.length > 0) {
              var resultsHtml = '<ul>';
              result.items.forEach((item, index) => {
                resultsHtml += '<li><a href="#" onclick="selectLocation(' + item.position.lat + ',' + item.position.lng + '); return false;">' + item.address.label + '</a></li>';
              });
              resultsHtml += '</ul>';
              document.getElementById('results').innerHTML = resultsHtml;
            } else {
              alert('Location not found!');
            }
          }, (error) => {
            alert('Geocode error: ' + error.message);
          });
        }

        function selectLocation(lat, lng) {
          var position = { lat: lat, lng: lng };
          map.setCenter(position);
          map.setZoom(14);
          var marker = new H.map.Marker(position);
          map.addObject(marker);
        }

        window.onload = initMap;
      </script>
    </head>
    <body>
      <div id="searchBar">
        <input type="text" id="searchInput" placeholder="Rechercher un endroit...">
        <button id="searchButton">Rechercher</button>
      </div>
      <div id="results" style="position: absolute; top: 50px; right: 10px; background: white; z-index: 1000; padding: 10px; border-radius: 5px; box-shadow: 0 2px 6px rgba(0,0,0,0.3);"></div>
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
