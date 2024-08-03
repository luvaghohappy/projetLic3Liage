import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtnom = TextEditingController();
  TextEditingController txtpostnom = TextEditingController();
  TextEditingController txtprenom = TextEditingController();
  TextEditingController txtemail = TextEditingController();

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

  Future<void> saveUserData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<void> insertData() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez corriger les erreurs avant de soumettre.'),
        ),
      );
      return;
    }

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("http://192.168.43.148:81/projetSV/operateur.php"),
    );

    request.fields['nom'] = txtnom.text;
    request.fields['postnom'] = txtpostnom.text;
    request.fields['prenom'] = txtprenom.text;
    request.fields['email'] = txtemail.text;

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

      try {
        final responseJson = jsonDecode(responseBody);

        if (responseJson['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: const [
                  Icon(Icons.check, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Enregistrement réussi avec succès'),
                ],
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 5),
              behavior: SnackBarBehavior.floating,
            ),
          );
          await saveUserData('nom', txtnom.text);
          await saveUserData('postnom', txtpostnom.text);
          await saveUserData('prenom', txtprenom.text);
          await saveUserData('email', txtemail.text);
          await saveUserData('image_path', responseJson['image_path']);

          // Effacer les champs après un enregistrement réussi
          _formKey.currentState!.reset();
          setState(() {
            _imageFile = null;
            txtnom.clear();
            txtpostnom.clear();
            txtprenom.clear();
            txtemail.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  'Erreur lors de l\'enregistrement: ${responseJson['error']}'),
            ),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur de décodage JSON: $responseBody'),
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

  InputDecoration buildInputDecoration(String labelText, String hintText,
      [Widget? suffix]) {
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
      suffixIcon: suffix,
      errorText: null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "FORMULAIRE D'ENREGISTREMENT OPERATEUR",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                GestureDetector(
                  onTap: getImage,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 192, 146, 9),
                    radius: 50,
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
                const Text('Choisissez une photo de profil'),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                TextFormField(
                  controller: txtnom,
                  decoration: buildInputDecoration('Nom', 'Entrez votre nom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre nom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtpostnom,
                  decoration:
                      buildInputDecoration('Postnom', 'Entrez votre postnom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre postnom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: txtprenom,
                  decoration:
                      buildInputDecoration('Prénom', 'Entrez votre prénom'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre prénom';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: txtemail,
                  decoration:
                      buildInputDecoration('Email', 'Entrez votre email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer votre email';
                    } else if (!RegExp(r'^[\w-]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Veuillez entrer un email valide';
                    }
                    return null;
                  },
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: insertData,
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromARGB(255, 187, 142, 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Soumettre'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
