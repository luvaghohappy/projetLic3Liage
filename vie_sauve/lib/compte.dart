import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vie_sauve/login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MonComptePage extends StatefulWidget {
  @override
  _MonComptePageState createState() => _MonComptePageState();
}

class _MonComptePageState extends State<MonComptePage> {
  String? nom,
      postnom,
      prenom,
      sexe,
      dateNaissance,
      adresse,
      etatCivil,
      nombreEnfant,
      etatSanitaire,
      allergie,
      taille,
      poids,
      numero,
      email,
      imagePath,
      userId;

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
      nombreEnfant = prefs.getString('nombre_enfant');
      etatSanitaire = prefs.getString('Etat_sanitaire');
      allergie = prefs.getString('allergie');
      taille = prefs.getString('Taille');
      poids = prefs.getString('Poids');
      numero = prefs.getString('Numero');
      email = prefs.getString('email');
      imagePath = prefs.getString('image_path');
      userId = prefs.getString('Userid'); // Load the UserId
    });
  }

  void _showEditDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController nomController = TextEditingController(text: nom);
        TextEditingController postnomController =
            TextEditingController(text: postnom);
        TextEditingController prenomController =
            TextEditingController(text: prenom);
        TextEditingController sexeController =
            TextEditingController(text: sexe);
        TextEditingController dateNaissanceController =
            TextEditingController(text: dateNaissance);
        TextEditingController adresseController =
            TextEditingController(text: adresse);
        TextEditingController etatCivilController =
            TextEditingController(text: etatCivil);
        TextEditingController nombreEnfantController =
            TextEditingController(text: nombreEnfant);
        TextEditingController etatSanitaireController =
            TextEditingController(text: etatSanitaire);
        TextEditingController allergieController =
            TextEditingController(text: allergie);
        TextEditingController tailleController =
            TextEditingController(text: taille);
        TextEditingController poidsController =
            TextEditingController(text: poids);
        TextEditingController numeroController =
            TextEditingController(text: numero);
        TextEditingController emailController =
            TextEditingController(text: email);

        return AlertDialog(
          title: const Text("Modifier les informations"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                _buildTextField("Nom", nomController),
                _buildTextField("Postnom", postnomController),
                _buildTextField("Prénom", prenomController),
                _buildTextField("Sexe", sexeController),
                _buildTextField("Date de Naissance", dateNaissanceController),
                _buildTextField("Adresse", adresseController),
                _buildTextField("État Civil", etatCivilController),
                _buildTextField("Nombre d'enfants", nombreEnfantController),
                _buildTextField("État Sanitaire", etatSanitaireController),
                _buildTextField("Allergies", allergieController),
                _buildTextField("Taille", tailleController),
                _buildTextField("Poids", poidsController),
                _buildTextField("Numéro", numeroController),
                _buildTextField("Email", emailController),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Annuler"),
            ),
            TextButton(
              onPressed: () async {
                await _updateUserData(
                  nomController.text,
                  postnomController.text,
                  prenomController.text,
                  sexeController.text,
                  dateNaissanceController.text,
                  adresseController.text,
                  etatCivilController.text,
                  nombreEnfantController.text,
                  etatSanitaireController.text,
                  allergieController.text,
                  tailleController.text,
                  poidsController.text,
                  numeroController.text,
                  emailController.text,
                );
                Navigator.of(context).pop();
              },
              child: const Text("Enregistrer"),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Future<void> _updateUserData(
    String nom,
    String postnom,
    String prenom,
    String sexe,
    String dateNaissance,
    String adresse,
    String etatCivil,
    String nombreEnfant,
    String etatSanitaire,
    String allergie,
    String taille,
    String poids,
    String numero,
    String email,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Mettre à jour les préférences partagées
    await prefs.setString('nom', nom);
    await prefs.setString('postnom', postnom);
    await prefs.setString('prenom', prenom);
    await prefs.setString('sexe', sexe);
    await prefs.setString('Date_naissance', dateNaissance);
    await prefs.setString('Adresse', adresse);
    await prefs.setString('Etat_civil', etatCivil);
    await prefs.setString('nombre_enfant', nombreEnfant);
    await prefs.setString('Etat_sanitaire', etatSanitaire);
    await prefs.setString('allergie', allergie);
    await prefs.setString('Taille', taille);
    await prefs.setString('Poids', poids);
    await prefs.setString('Numero', numero);
    await prefs.setString('email', email);

    // Assurer que userId n'est pas nul
    final userId = prefs.getString('userId');
    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID utilisateur manquant'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Préparer les données pour la requête
    final Map<String, String> body = {
      'Userid': userId,
      'nom': nom,
      'postnom': postnom,
      'prenom': prenom,
      'sexe': sexe,
      'Date_naissance': dateNaissance,
      'Adresse': adresse,
      'Etat_civil': etatCivil,
      'Etat_sanitaire': etatSanitaire,
      'allergie': allergie,
      'Taille': taille,
      'Poids': poids,
      'Numero': numero,
      'email': email,
    };

    // Ajouter nombre_enfant uniquement si etat_civil est mariee
    if (etatCivil == 'mariee') {
      body['nombre_enfant'] = nombreEnfant;
    }

    // Envoyer les données mises à jour au backend
    final response = await http.post(
      Uri.parse("http://192.168.43.148:81/projetSV/updateuser.php"),
      body: body,
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'success') {
        // Afficher un Snackbar de succès
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: const [
                Icon(Icons.check, color: Colors.white),
                SizedBox(width: 8),
                Text('Modification réussie'),
              ],
            ),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 5),
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Erreur lors de la modification : ${result['error']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la modification'),
          backgroundColor: Colors.red,
        ),
      );
    }

    // Recharger les données mises à jour
    _loadUserData();
  }

  Future<void> deleteUserAccount(String id) async {
    final response = await http.post(
      Uri.parse("http://192.168.43.148:81/projetSV/deleteuser.php"),
      body: {'Userid': id},
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'success') {
        // Clear SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Show success Snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Compte supprimé avec succès'),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to login page after deletion
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MyForm()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de la suppression : ${result['error']}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la suppression'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _confirmDelete() {
    if (userId != null) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirmation de suppression'),
            content: const Text('Voulez-vous vraiment supprimer ce compte ?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Annuler'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteUserAccount(userId!); // Pass the userId here
                },
                child: const Text('Supprimer'),
              ),
            ],
          );
        },
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
              padding: EdgeInsets.only(top: 20),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 150,
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Vous avez changé d'adresse, vous avez été diagnostiqué avec une maladie, vous avez développé des allergies, ou vous avez n'importe quel autre changement dans votre vie. N'hésitez pas à nous en informer.",
                            style: GoogleFonts.abel(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ElevatedButton(
                            onPressed: _showEditDialog,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Modifier vos informations'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Container(
                    height: 130,
                    width: 350,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Vie_Sauve est une application qui vous permet d'être en sécurité tout le temps. Êtes-vous vraiment sûr de vouloir supprimer ce compte ?",
                            style: GoogleFonts.abel(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: ElevatedButton(
                            onPressed: _confirmDelete,
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: const Text('Supprimer ce compte'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                ],
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
