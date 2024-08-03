import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class VoiceCall extends StatefulWidget {
  const VoiceCall({super.key});

  @override
  State<VoiceCall> createState() => _VoiceCallState();
}

class _VoiceCallState extends State<VoiceCall> {
  String? postnom;
  String? prenom;
  String? imagePath;
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      postnom = prefs.getString('postnom');
      prenom = prefs.getString('prenom');
    });
    print('Image Path: $imagePath');
  }

  @override
  void initState() {
    super.initState();
    // requestPermissions();
    // fetchOpID();
    fetch();
  }

  List<Map<String, dynamic>> items = [];

  Future<void> fetch() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.148:81/projetSV/chargerop.php"),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor: Colors.blue,
                                backgroundImage: item['image_path'] != null
                                    ? NetworkImage(
                                        "http://192.168.43.148:81/projetSV/${item['image_path']}")
                                    : null,
                                child: item['image_path'] == null
                                    ? const Icon(Icons.image,
                                        size: 10, color: Colors.grey)
                                    : null,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                item['opId'] ?? 'N/A',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 20),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.green,
                                radius: 15,
                                child: Center(
                                  child: IconButton(
                                    color: Colors.white,
                                    iconSize: 12,
                                    icon: const Icon(Icons.call),
                                    onPressed: () {},
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
