import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  String? imagePath;
  String? prenom;

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prenom = prefs.getString('prenom');
      imagePath = prefs.getString('image_path');
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
    fetch();
  }

  List<Map<String, dynamic>> items = [];

  Future<void> fetch() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.148:81/projetSV/charger.php"),
      );
      setState(() {
        items = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load items'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = imagePath != null
        ? "http://192.168.43.148:81/projetSV/$imagePath"
        : null;
    print('Image URL: $imageUrl');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'VIE_SAUVE',
          style: TextStyle(fontSize: 12, color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          radius: 10,
          backgroundImage: AssetImage(
            'assets/logo.jpg',
          ),
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            backgroundColor: Colors.grey,
            child: imageUrl == null ? const Icon(Icons.person, size: 15) : null,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          Center(
            child: Text(
              prenom ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Utilisateurs ',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.blue,
                      backgroundImage: item['image_path'] != null
                          ? NetworkImage(
                              "http://192.168.43.148:81/projetSV/${item['image_path']}")
                          : null,
                      child: item['image_path'] == null
                          ? const Icon(Icons.image,
                              size: 20, color: Colors.grey)
                          : null,
                    ),
                    title: Text(
                      item['nom'] ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      item['prenom'] ?? 'N/A',
                      style: const TextStyle(
                        color: Colors.black26,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 15,
                          child: IconButton(
                            color: Colors.white,
                            iconSize: 12,
                            icon: const Icon(Icons.call),
                            onPressed: () {
                              // Handle call action
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.red,
                          radius: 15,
                          child: IconButton(
                            color: Colors.white,
                            iconSize: 12,
                            icon: const Icon(Icons.live_tv),
                            onPressed: () {
                              // Handle live stream action
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          radius: 15,
                          child: IconButton(
                            color: Colors.white,
                            iconSize: 12,
                            icon: const Icon(Icons.chat),
                            onPressed: () {
                              // Handle chat action
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
