import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:http/http.dart' as http;

class Users2 extends StatefulWidget {
  const Users2({super.key});

  @override
  State<Users2> createState() => _Users2State();
}

class _Users2State extends State<Users2> {
  TextEditingController txtnom = TextEditingController();
  TextEditingController txtpostnom = TextEditingController();
  TextEditingController txtprenom = TextEditingController();
  TextEditingController txtemail = TextEditingController();
  TextEditingController txtpassword = TextEditingController();
  TextEditingController txtrole = TextEditingController();
  late html.File _selectedFile;

  Future<void> _getImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      setState(() {
        _selectedFile = file;
      });
    });
  }

  Future<void> insertData() async {
    if (_selectedFile != null) {
      try {
        var request = http.MultipartRequest(
          'POST',
          Uri.parse("http://192.168.43.148:81/projetSV/insertuser.php"),
        );
        request.fields['nom'] = txtnom.text;
        request.fields['postnom'] = txtpostnom.text;
        request.fields['prenom'] = txtprenom.text;
        request.fields['email'] = txtemail.text;
        request.fields['passwords'] = txtpassword.text;
        request.fields['roles'] = txtrole.text;

        var image = await http.MultipartFile.fromPath(
          'profil',
          _selectedFile.relativePath!,
        );
        request.files.add(image);

        var response = await request.send();

        if (response.statusCode == 200) {
          txtnom.clear();
          txtpostnom.clear();
          txtprenom.clear();
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

  List<Map<String, dynamic>> items = [];

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.148:81/projetSV/chargeruser.php"),
      );

      setState(() {
        items = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load items'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData(); // Load initial data when the app starts
  }

  Future<void> showInsertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ajouter Formation'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 80,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.white),
                  ),
                  child: _selectedFile != null
                      ? Image.network(_selectedFile.relativePath!)
                      : IconButton(
                          onPressed: _getImage,
                          icon: const Icon(Icons.file_upload),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtnom,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelText: 'Nom',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtpostnom,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelText: 'Postnom',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtprenom,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelText: 'Prenom',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: txtemail,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
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
                        borderSide: BorderSide(color: Colors.grey.shade400),
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
                        borderSide: BorderSide(color: Colors.grey.shade400),
                      ),
                      labelText: 'Role',
                      labelStyle: const TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: insertData,
              child: const Text('Enregistrer'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Agents Operateurs'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Nom')),
                  DataColumn(label: Text('Postnom')),
                  DataColumn(label: Text('Prenom')),
                  DataColumn(label: Text('email')),
                  DataColumn(label: Text('passwords')),
                  DataColumn(label: Text('roles')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: List.generate(items.length, (index) {
                  final item = items[index];
                  return DataRow(
                    cells: [
                      DataCell(Text(item['nom'] ?? '')),
                      DataCell(Text(item['postnom'] ?? '')),
                      DataCell(Text(item['prenom'] ?? '')),
                      DataCell(Text(item['email'] ?? '')),
                      DataCell(
                        Text(item['passwords'] ?? ''),
                      ),
                      DataCell(Text(item['roles'] ?? '')),
                      DataCell(
                        Row(
                          children: [
                            IconButton(
                              iconSize: 15,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // deleteData(context, item['id']);
                              },
                            ),
                            IconButton(
                              iconSize: 15,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                // _showEditDialog(item);
                              },
                            ),
                          ],
                        ),
                      ),
                      
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showInsertDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
