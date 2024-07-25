import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController txtnom = TextEditingController();
  TextEditingController txtpostnom = TextEditingController();
  TextEditingController txtprenom = TextEditingController();
  TextEditingController txtsexe = TextEditingController();
  TextEditingController txtEtat_civil = TextEditingController();
  TextEditingController txtAdresse = TextEditingController();
  TextEditingController txtEtat_sanitaire = TextEditingController();
  TextEditingController txtalergie = TextEditingController();
  TextEditingController txtnombre_enfant = TextEditingController();

  File? _imageFile;
  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> insertData() async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.43.148:81/MRG/insertformation.php"),
    );

    request.fields['nom'] = txtnom.text;
    request.fields['postnom'] = txtpostnom.text;
    request.fields['prenom'] = txtprenom.text;
    request.fields['sexe'] = txtsexe.text;
    request.fields['Etat_civil'] = txtEtat_civil.text;
    request.fields['Adresse'] = txtAdresse.text;
    request.fields['Etat_sanitaire'] = txtEtat_sanitaire.text;
    request.fields['alergie'] = txtalergie.text;
    request.fields['nombre_enfant'] = txtnombre_enfant.text;

    if (_imageFile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          _imageFile!.path,
        ),
      );
    }

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final responseJson = jsonDecode(responseBody);

      if (responseJson['status'] == 'success') {
        txtnom.clear();
        txtpostnom.clear();
        txtprenom.clear();
        txtsexe.clear();
        txtEtat_civil.clear();
        txtAdresse.clear();
        txtEtat_sanitaire.clear();
        txtalergie.clear();
        txtnombre_enfant.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enregistrement réussi'),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erreur lors de l\'enregistrement: ${responseJson['error']}'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de l\'enregistrement'),
        ),
      );
    }
  }

  InputDecoration buildInputDecoration(String labelText, String hintText) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.blue),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: getImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? const Icon(
                        Icons.add_a_photo,
                        size: 20,
                        color: Colors.white,
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: txtnom,
                          decoration:
                              buildInputDecoration('Nom', 'Entrez votre nom'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtpostnom,
                          decoration: buildInputDecoration(
                              'Postnom', 'Entrez votre postnom'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtprenom,
                          decoration: buildInputDecoration(
                              'Prénom', 'Entrez votre prénom'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtsexe,
                          decoration: buildInputDecoration(
                              'Sexe', 'Entrez votre sexe'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtEtat_civil,
                          decoration: buildInputDecoration(
                              'État Civil', 'Entrez votre état civil'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtAdresse,
                          decoration: buildInputDecoration(
                              'Adresse', 'Entrez votre adresse'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtEtat_sanitaire,
                          decoration: buildInputDecoration('État Sanitaire',
                              'Entrez votre état sanitaire'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          controller: txtalergie,
                          decoration: buildInputDecoration(
                              'Allergie', 'Entrez vos allergies'),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: txtnombre_enfant,
                          decoration: buildInputDecoration(
                              'Nombre d\'Enfants',
                              'Entrez le nombre d\'enfants'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: insertData,
              child: const Text('Insérer'),
            ),
          ],
        ),
      ),
    );
  }
}
