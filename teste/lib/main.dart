import 'package:flutter/material.dart';
import 'homepage.dart';
import 'dart:html' as html;
import 'menu.dart';

void main() {
  // platformViewRegistry.registerViewFactory(
  //   'viewDiv',
  //   (int viewId) => html.DivElement()..id = 'viewDiv',
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Menu(),
    );
  }
}
