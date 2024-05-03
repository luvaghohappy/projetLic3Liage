
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:js/js.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// class HereMapsWidget extends StatefulWidget {
//   @override
//   _HereMapsWidgetState createState() => _HereMapsWidgetState();
// }

// class _HereMapsWidgetState extends State<HereMapsWidget> {
//   html.Element hereMapElement;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize HERE Maps
//     html.context['onHereMapsLoaded'] = allowInterop(() {
//       hereMapElement = html.document.getElementById('here-map');
//       _initializeMap();
//     });
//     _loadHereMapsScript();
//   }

//   void _loadHereMapsScript() {
//     final script = html.ScriptElement()
//       ..type = 'text/javascript'
//       ..src = 'https://js.api.here.com/v3/3.1/mapsjs-core.js'
//       ..async = true
//       ..onLoad.listen((_) {
//         _initializeMap();
//       });
//     html.document.body.nodes.add(script);
//   }

//   void _initializeMap() {
//     if (hereMapElement != null) {
//       final platform = html.Platform();
//       final defaultLayers = platform.createDefaultLayers();
//       final map = html.Map(hereMapElement, {
//         'center': {'lat': 52.52, 'lng': 13.405},
//         'zoom': 14,
//         'layers': [
//           defaultLayers.vector.normal.map,
//         ]
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       height: 400, // Adjust as needed
//       child: HtmlElementView(viewType: 'here-map'),
//     );
//   }
// }