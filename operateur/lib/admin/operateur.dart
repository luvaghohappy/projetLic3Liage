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
  Uint8List? _selectedFileBytes;

  Future<void> _getImage() async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input.accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();
      reader.readAsArrayBuffer(file);

      reader.onLoadEnd.listen((e) {
        setState(() {
          _selectedFileBytes = reader.result as Uint8List;
        });
      });
    });
  }

  Future<void> insertData() async {
    if (_selectedFileBytes != null) {
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

        var image = _selectedFileBytes != null
            ? http.MultipartFile.fromBytes(
                'profil',
                _selectedFileBytes!,
                filename: 'image.jpg',
              )
            : null;

        if (image != null) {
          request.files.add(image);
        }

        var response = await request.send();

        if (response.statusCode == 200) {
          _selectedFileBytes = null;
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
          fetchData();
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
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Ajouter Formation'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _selectedFileBytes != null
                          ? Image.memory(_selectedFileBytes!)
                          : IconButton(
                              onPressed: () async {
                                final html.FileUploadInputElement input =
                                    html.FileUploadInputElement();
                                input.accept = 'image/*';
                                input.click();

                                input.onChange.listen((event) {
                                  final file = input.files!.first;
                                  final reader = html.FileReader();
                                  reader.readAsArrayBuffer(file);

                                  reader.onLoadEnd.listen((e) {
                                    setState(() {
                                      _selectedFileBytes =
                                          reader.result as Uint8List;
                                    });
                                  });
                                });
                              },
                              icon: const Icon(Icons.file_upload),
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtnom,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Nom',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtpostnom,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Postnom',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtprenom,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Prenom',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtemail,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtpassword,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: txtrole,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          labelText: 'Role',
                          labelStyle: TextStyle(color: Colors.black),
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
      },
    );
  }

  Future<void> deleteData(String? userId) async {
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID utilisateur invalide'),
        ),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse("http://192.168.43.148:81/projetSV/deleteop.php"),
        body: {'id': userId},
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'success') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Suppression réussie'),
            ),
          );
          fetchData();
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Erreur lors de la suppression : ${result['message']}'),
            ),
          );
        }
      } else {
        throw Exception('Erreur lors de la suppression');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression: $e'),
        ),
      );
    }
  }

  Future<void> _confirmDelete(String? userId) async {
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('ID utilisateur invalide'),
        ),
      );
      return;
    }

    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation de suppression'),
          content: const Text(
            'Êtes-vous sûr de vouloir supprimer cet enregistrement ?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Supprimer'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await deleteData(userId);
    }
  }

  Future<void> _showEditDialog(Map<String, dynamic> item) async {
    txtnom.text = item['nom'] ?? '';
    txtpostnom.text = item['postnom'] ?? '';
    txtprenom.text = item['prenom'] ?? '';
    txtemail.text = item['email'] ?? '';
    txtpassword.text = item['passwords'] ?? '';
    txtrole.text = item['roles'] ?? '';

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modifier Utilisateur'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: txtnom,
                  decoration: const InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: txtpostnom,
                  decoration: const InputDecoration(labelText: 'Postnom'),
                ),
                TextField(
                  controller: txtprenom,
                  decoration: const InputDecoration(labelText: 'Prenom'),
                ),
                TextField(
                  controller: txtemail,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: txtpassword,
                  decoration: const InputDecoration(labelText: 'Mot de passe'),
                ),
                TextField(
                  controller: txtrole,
                  decoration: const InputDecoration(labelText: 'Rôles'),
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
              onPressed: () {
                updateData(item['userId'].toString());
              },
              child: const Text('Modifier'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateData(String id) async {
    final nom = txtnom.text;
    final postnom = txtpostnom.text;
    final prenom = txtprenom.text;
    final email = txtemail.text;
    final passwords = txtpassword.text;
    final roles = txtrole.text;

    try {
      final response = await http.post(
        Uri.parse("http://192.168.43.148:81/projetSV/updateop.php"),
        body: {
          'nom': nom,
          'postnom': postnom,
          'prenom': prenom,
          'email': email,
          'passwords': passwords,
          'roles': roles,
          'userId': id,
        },
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mise à jour réussie'),
          ),
        );
        // Actualiser les données après la mise à jour
        fetchData();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la mise à jour'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la mise à jour: $e'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
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
                              color: Colors.green,
                              iconSize: 15,
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(item);
                              },
                            ),
                            IconButton(
                              color: Colors.red,
                              iconSize: 15,
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _confirmDelete(item['userId']);
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
        child: const Icon(Icons.add),
      ),
    );
  }
}
