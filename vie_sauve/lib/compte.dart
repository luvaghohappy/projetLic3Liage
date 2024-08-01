import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vie_sauve/login.dart';

class MonComptePage extends StatefulWidget {
  @override
  _MonComptePageState createState() => _MonComptePageState();
}

class _MonComptePageState extends State<MonComptePage> {
  String? nom;
  String? postnom;
  String? prenom;
  String? sexe;
  String? dateNaissance;
  String? adresse;
  String? etatCivil;
  String? nombreEnfant;
  String? etatSanitaire;
  String? allergie;
  String? taille;
  String? poids;
  String? numero;
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
      sexe = prefs.getString('sexe');
      dateNaissance = prefs.getString('Date_naissance');
      adresse = prefs.getString('Adresse');
      etatCivil = prefs.getString('Etat_civil');
      nombreEnfant = prefs.getString('nombre_enfant') ?? '0';
      etatSanitaire = prefs.getString('Etat_sanitaire');
      allergie = prefs.getString('allergie');
      taille = prefs.getString('Taille');
      poids = prefs.getString('Poids');
      numero = prefs.getString('Numero');
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
            Padding(
              padding: const EdgeInsets.only(left: 170),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyForm(),
                  ));
                },
                child: Container(
                  height: 30,
                  width: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text('Créer un compte'),
                  ),
                ),
              ),
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
              padding: EdgeInsets.only(top: 20),
            ),
            _buildInfoCard(Icons.person, Colors.blue, 'Nom:', nom),
            _buildInfoCard(
                Icons.person_outline, Colors.green, 'Postnom:', postnom),
            _buildInfoCard(Icons.person_pin, Colors.purple, 'Prénom:', prenom),
            _buildInfoCard(Icons.wc, Colors.orange, 'Sexe:', sexe),
            _buildInfoCard(
                Icons.cake, Colors.pink, 'Date de Naissance:', dateNaissance),
            _buildInfoCard(Icons.home, Colors.red, 'Adresse:', adresse),
            _buildInfoCard(Icons.group, Colors.teal, 'État Civil:', etatCivil),
            _buildInfoCard(Icons.child_care, Colors.brown, 'Nombre d\'enfants:',
                nombreEnfant),
            _buildInfoCard(Icons.local_hospital, Colors.indigo,
                'État Sanitaire:', etatSanitaire),
            _buildInfoCard(Icons.healing, Colors.amber, 'Allergies:', allergie),
            _buildInfoCard(Icons.straighten, Colors.cyan, 'Taille:', taille),
            _buildInfoCard(Icons.line_weight, Colors.lime, 'Poids:', poids),
            _buildInfoCard(Icons.phone, Colors.deepPurple, 'Numéro:', numero),
            _buildInfoCard(Icons.email, Colors.deepOrange, 'Email:', email),
            const Padding(
              padding: EdgeInsets.only(top: 10),
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
