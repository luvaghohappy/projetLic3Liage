import 'package:flutter/material.dart';

class Guides extends StatefulWidget {
  const Guides({super.key});

  @override
  State<Guides> createState() => _GuidesState();
}

class _GuidesState extends State<Guides> {
  @override
  Widget build(BuildContext context) {
    // final h = MediaQuery.of(context).size.height;
    // final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: const [
          Text("Guide d'utilisation"),
          Text("Notre application "),
        ],
      ),
    );
  }
}
