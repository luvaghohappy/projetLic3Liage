import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class MonComptePage extends StatefulWidget {
  @override
  _MonComptePageState createState() => _MonComptePageState();
}

class _MonComptePageState extends State<MonComptePage> {
  bool _isAccepted = false;
  String? nom;
  String? postnom;
  String? prenom;
  String? email;
  String? imagePath;

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
      email = prefs.getString('email');
      imagePath = prefs.getString('image_path');
    });
    print('Image Path: $imagePath');
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = imagePath != null
        ? "http://192.168.43.148:81/projetSV/$imagePath"
        : null;
    print('Image URL: $imageUrl');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 30),
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.blue,
                    backgroundImage:
                        imageUrl != null ? NetworkImage(imageUrl) : null,
                    child: imageUrl == null
                        ? const Icon(Icons.person, size: 20, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: -1,
                    right: -1,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors
                              .white, // Optionnel: ajoute une bordure blanche
                          width: 2, // Optionnel: largeur de la bordure
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60),
            ),
            _buildInfoCard(Icons.person, Colors.blue, 'Nom:', nom),
            _buildInfoCard(
                Icons.person_outline, Colors.green, 'Postnom:', postnom),
            _buildInfoCard(Icons.person_pin, Colors.purple, 'Prénom:', prenom),
            _buildInfoCard(Icons.email, Colors.deepOrange, 'Email:', email),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 320,
                width: 350,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Je jure solennellement, en tant qu'opérateur d'urgence, de respecter et de protéger les valeurs fondamentales de ma profession. Je m'engage à:",
                        style: GoogleFonts.abel(fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Assurer la Sécurité : Mettre tout en œuvre pour assurer la sécurité et le bien-être des personnes que je sers, en répondant avec diligence et compétence à chaque appel d'urgence.",
                        style: GoogleFonts.abel(fontSize: 14),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Confidentialité : Protéger la confidentialité des informations recueillies au cours des interventions et traiter chaque cas avec la plus stricte confidentialité, conformément aux lois et règlements en vigueur.",
                        style: GoogleFonts.abel(fontSize: 14),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Checkbox(
                            value: _isAccepted,
                            onChanged: (bool? value) {
                              setState(() {
                                _isAccepted = value ?? false;
                              });
                            },
                          ),
                          Text(
                            "J'accepte les conditions énoncées ci-dessus.",
                            style: GoogleFonts.abel(fontSize: 14),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, Color iconColor, String label, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(width: 8.0),
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                value ?? 'N/A',
                style: const TextStyle(fontSize: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
