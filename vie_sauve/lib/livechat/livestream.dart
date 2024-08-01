import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vie_sauve/livechat/chat.dart';
import 'package:vie_sauve/livechat/stream.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  String opID = ''; // Stocke l'opID de l'opérateur

  @override
  void initState() {
    super.initState();
    requestPermissions();
    fetchOpID(); // Récupère l'opID lors de l'initialisation
  }

  Future<void> requestPermissions() async {
    await Permission.microphone.request();
    await Permission.camera.request();
  }

  Future<void> fetchOpID() async {
    final response = await http.get(
      Uri.parse('https://votrebackend.com/getOpID'), // Remplacez par votre endpoint backend
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        opID = data['opID']; // Récupère l'opID depuis la réponse JSON
      });
    } else {
      // Gérer les erreurs
      print('Erreur lors de la récupération de l\'opID');
    }
  }

  void startVoiceCall() {
    if (opID.isEmpty) {
      // Gérer le cas où l'opID n'est pas encore chargé
      print('L\'opID de l\'opérateur n\'est pas disponible');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ZegoUIKitPrebuiltCall(
          appID: 1926018635,
          appSign: '46eed34d55a21d12d56f8dd7c1b450b7d83f4c5eb8ddffbc40538288590c26d7',
          userID: '1',
          userName: 'user1',
          callID: opID, // Utilise l'opID de l'opérateur pour l'appel
          config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Communication Options',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const LiveStream(),
                ));
              },
              icon: const Icon(Icons.live_tv, size: 30),
              label: const Text('Livestream'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.25, vertical: h * 0.02),
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                startVoiceCall();
              },
              icon: const Icon(Icons.call, size: 30),
              label: const Text('Appel vocal'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.25, vertical: h * 0.02),
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Chatapp(),
                ));
              },
              icon: const Icon(Icons.chat, size: 30),
              label: const Text('Chat'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: w * 0.25, vertical: h * 0.02),
                primary: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                textStyle: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
