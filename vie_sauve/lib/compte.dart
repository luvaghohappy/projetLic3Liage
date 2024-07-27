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
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = imagePath != null
        ? "http://192.168.43.148:81/projetSV/uploads/$imagePath"
        : null;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 200),
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
          const SizedBox(height: 20),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.blue,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            child: imageUrl == null
                ? const Icon(Icons.image, size: 50, color: Colors.grey)
                : null,
          ),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: ListView(
                children: [
                  _buildInfoCard('Nom:', nom),
                  _buildInfoCard('Postnom:', postnom),
                  _buildInfoCard('Prénom:', prenom),
                  _buildInfoCard('Sexe:', sexe),
                  _buildInfoCard('Date de Naissance:', dateNaissance),
                  _buildInfoCard('Adresse:', adresse),
                  _buildInfoCard('État Civil:', etatCivil),
                  _buildInfoCard('Nombre d\'enfants:', nombreEnfant),
                  _buildInfoCard('État Sanitaire:', etatSanitaire),
                  _buildInfoCard('Allergies:', allergie),
                  _buildInfoCard('Taille:', taille),
                  _buildInfoCard('Poids:', poids),
                  _buildInfoCard('Numéro:', numero),
                  _buildInfoCard('Email:', email),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String label, String? value) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
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
