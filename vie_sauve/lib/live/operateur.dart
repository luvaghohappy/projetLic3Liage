import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:url_launcher/url_launcher.dart';

class Livechat extends StatefulWidget {
  const Livechat({super.key});

  @override
  State<Livechat> createState() => _LivechatState();
}

class _LivechatState extends State<Livechat> {
  final number = '+243828797626';
  String? imagePath;
  String? prenom;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prenom = prefs.getString('prenom');
      imagePath = prefs.getString('image_path');
    });
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
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: const CircleAvatar(
          radius: 15,
          backgroundImage: AssetImage('assets/logo.jpg'),
        ),
        actions: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.blue,
                backgroundImage:
                    imageUrl != null ? NetworkImage(imageUrl) : null,
                child: imageUrl == null
                    ? const Icon(Icons.person, size: 20, color: Colors.grey)
                    : null,
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
        ],
      ),
      body: Column(
      
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 30),
          ),
          const Text(
            'Communiquez avec les operateurs',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 120),
          ),
          Column(
            children: [
              Container(
                height: 60,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment
                        .center, // Centrer le contenu de la ligne
                    children: const [
                      Icon(
                        Icons.live_tv_outlined,
                        size: 30, // Agrandir l'icône
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                      ),
                      Text(
                        'Lancez live',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20), // Agrandir le texte
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              GestureDetector(
                onTap: () async {
                  await FlutterPhoneDirectCaller.callNumber(number);
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centrer le contenu de la ligne
                      children: const [
                        Icon(
                          Icons.call,
                          size: 30, // Agrandir l'icône
                          color: Colors.white,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Text(
                          'Appelez',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20), // Agrandir le texte
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              GestureDetector(
                onTap: () async {
                  final Uri smsUri = Uri(
                    scheme: 'sms',
                    path: number,
                  );
                  if (await canLaunchUrl(smsUri)) {
                    await launchUrl(smsUri);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Impossible d\'ouvrir l\'application de messagerie.'),
                      ),
                    );
                  }
                },
                child: Container(
                  height: 60,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centrer le contenu de la ligne
                      children: const [
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                          size: 30, // Agrandir l'icône
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                        ),
                        Text(
                          'Chat',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20), // Agrandir le texte
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
