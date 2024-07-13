import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
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
  InAppWebViewController? _webViewController;

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

          window.addEventListener('message', function(event) {
            var data = event.data;
            if (data.type === 'emergencyLocation') {
              var position = { lat: data.latitude, lng: data.longitude };
              var marker = new H.map.Marker(position);
              map.addObject(marker);
              map.setCenter(position);
              map.setZoom(14);
            }
          }, false);
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

  void _fetchAndDisplayEmergencyCalls() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.43.148:81/projetSV/get_calls.php'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> calls = json.decode(response.body);
        for (var call in calls) {
          final double latitude = double.parse(call['latitude']);
          final double longitude = double.parse(call['longitude']);
          final script = '''
            window.postMessage({
              type: 'emergencyLocation',
              latitude: $latitude,
              longitude: $longitude
            });
          ''';
          _webViewController?.evaluateJavascript(source: script);
        }
      } else {
        throw Exception('Failed to load emergency calls');
      }
    } catch (e) {
      print('Error fetching emergency calls: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchAndDisplayEmergencyCalls();
    // Fetch new emergency calls every 5 seconds
    Timer.periodic(const Duration(seconds: 5), (timer) {
      _fetchAndDisplayEmergencyCalls();
    });
  }
}
