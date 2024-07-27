import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  String? nom;
  String? postnom;
  String? prenom;
  String? sexe;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nom = prefs.getString('nom');
      postnom = prefs.getString('postnom');
      prenom = prefs.getString('prenom');
      sexe = prefs.getString('sexe');
    });
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
    });
  }

  Future<void> _sendData(String type) async {
    await _checkPermissions(); // Vérifier les permissions avant d'accéder à la localisation

    await _getCurrentLocation();
    if (nom != null &&
        postnom != null &&
        prenom != null &&
        sexe != null &&
        latitude != null &&
        longitude != null) {
      final response = await http.post(
        Uri.parse('http://192.168.43.148:81/projetSV/calls.php/$type'),
        body: {
          'nom': nom!,
          'postnom': postnom!,
          'prenom': prenom!,
          'sexe': sexe!,
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Data sent successfully');
      } else {
        print('Failed to send data');
      }
    } else {
      print('User data or location is missing');
    }
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.status;
    if (!status.isGranted) {
      var result = await Permission.location.request();
      if (result.isGranted) {
        print('Location permission granted');
      } else {
        print('Location permission denied');
        // Vous pouvez afficher une boîte de dialogue pour informer l'utilisateur
      }
    } else {
      print('Location permission already granted');
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'VIE_SAUVE URGENCES',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 80),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SOSButton(
                text: 'SOS AMBULANCE',
                imageUrl: 'assets/ambulance.png',
                onPressed: () {
                  _sendData('ambulance');
                },
              ),
              SOSButton(
                text: 'SOS POLICE',
                imageUrl: 'assets/policier.jpg',
                onPressed: () {
                  _sendData('police');
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SOSButton(
                text: 'SOS POMPIER',
                imageUrl: 'assets/pompier.png',
                onPressed: () {
                  _sendData('pompier');
                },
              ),
              SOSButton(
                text: 'CHAT LIVE',
                imageUrl: 'assets/chat.jpg',
                onPressed: () {
                  // Action spécifique pour CHAT LIVE
                  print('CHAT LIVE pressed');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SOSButton extends StatelessWidget {
  final String text;
  final String imageUrl;
  final VoidCallback onPressed;

  const SOSButton({
    required this.text,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Material(
            elevation: 5,
            shape: const CircleBorder(),
            shadowColor: Colors.black,
            child: CircleAvatar(
              radius: 70,
              backgroundColor: const Color.fromARGB(255, 202, 155, 13),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(imageUrl),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
