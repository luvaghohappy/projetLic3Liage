import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Homepage extends StatelessWidget {
  final String email;
  final String profil;

  Homepage({Key? key, required this.email, required this.profil})
      : super(key: key);

  Future<void> logoutUser(String email, BuildContext context) async {
    final url = 'http://192.168.43.148:81/projetSV/selectUser.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': email,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        Navigator.pop(context);
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erreur'),
              content: Text(responseData['message']),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erreur'),
            content: const Text(
                'Erreur lors de la déconnexion. Veuillez réessayer plus tard.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: MemoryImage(base64Decode(profil)),
                ),
                const SizedBox(width: 10),
                Text(
                  'Opérateur: $email',
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 100),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Appels'),
                ),
                 const Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Postes'),
                ),
                 const Padding(
                  padding: EdgeInsets.only(left: 10),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text('Appels'),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 200),
                ),
                TextButton(
                  onPressed: () => logoutUser(email, context),
                  child: const Text('Déconnexion'),
                ),
              ],
            ),
          ),
          Expanded(
            child: HtmlElementView(
              viewType: 'hereMap',
            ),
          )
        ],
      ),
    );
  }
}
