import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

class Users2 extends StatefulWidget {
  const Users2({super.key});

  @override
  State<Users2> createState() => _Users2State();
}

class _Users2State extends State<Users2> {
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtrole = TextEditingController();
  Uint8List? _imageBytes;
  late html.File _selectedFile; // Variable pour stocker le fichier sélectionné

  Future<void> _getImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        setState(() {
          _imageBytes = const Base64Decoder()
              .convert(reader.result.toString().split(",").last);
          _selectedFile = file; // Stockage du fichier sélectionné
        });
      });
    });
  }

  Future<void> insertData() async {
    if (_imageBytes != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("http://192.168.43.148:81/projetSV/insertuser.php"),
        );

        request.fields['email'] = txtemail.text;
        request.fields['passwords'] = txtpassword.text;
        request.fields['roles'] = txtrole.text;

        var image = http.MultipartFile.fromBytes(
          'profil',
          _imageBytes!,
          filename:
              _selectedFile.name, // Utilisation du nom fourni par l'utilisateur
        );
        request.files.add(image);

        var response = await request.send();

        if (response.statusCode == 200) {
          txtemail.clear();
          txtpassword.clear();
          txtrole.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Enregistrement réussi'),
            ),
          );
        } else {
          throw Exception('Erreur lors de l\'enregistrement');
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erreur lors de l\'enregistrement: $e'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez choisir une image'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 30)),
          Padding(
            padding: const EdgeInsets.only(left: 250),
            child: Container(
              height: 320,
              width: 600,
              child: Card(
                color: Colors.blueGrey, // Opacité ajustée ici (par exemple)
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextField(
                          controller: txtemail,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            labelText: 'Email',
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextField(
                          controller: txtpassword,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(13.0),
                        child: TextField(
                          controller: txtrole,
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            labelText: 'Role',
                            labelStyle: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(top: 10)),
                      Padding(
                        padding: const EdgeInsets.only(left: 250),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: insertData,
                              child: const Text('Insert'),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 70)),
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                // Vous pouvez personnaliser la décoration du conteneur selon vos besoins
                                borderRadius: BorderRadius.circular(
                                    8.0), // Par exemple, un coin arrondi
                                border: Border.all(
                                    color: Colors
                                        .white), // Ajoute une bordure grise
                              ),
                              child: _imageBytes != null
                                  ? Image.memory(
                                      _imageBytes!) // Affiche l'image si _imageBytes est non nul
                                  : IconButton(
                                      onPressed: _getImage,
                                      icon: const Icon(Icons.file_upload),
                                    ), // Sinon, affiche un bouton pour choisir une image
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
