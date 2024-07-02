import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'dart:ui' as ui;
import 'package:projet/menu.dart';

void main() {
  // Register the HTML view
  ui.platformViewRegistry.registerViewFactory('hereMap', (int viewId) {
    final div = html.DivElement()
      ..id = 'mapContainer'
      ..style.width = '100%'
      ..style.height = '100vh';
    return div;
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Web with HERE Maps',
      debugShowCheckedModeBanner: false,
      home: Menu(),
    );
  }
}
