import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool inLoginProcess = false;
  bool _obscureText = true;

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int _attempts = 0; // Variable pour suivre les tentatives
  bool _fieldsDisabled =
      false; // Variable pour savoir si les champs sont désactivés

  Future<void> loginUser() async {
    if (_fieldsDisabled) return; // Ne rien faire si les champs sont désactivés

    final url = 'http://192.168.43.148:81/projetSV/selectUser.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': emailController.text,
        'passwords': passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success']) {
        // Navigate to Homepage with just the email
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Homepage(
            email: emailController.text,
          ),
        ));
      } else {
        _attempts++;
        if (_attempts >= 3) {
          setState(() {
            _fieldsDisabled = true; // Désactiver les champs après 3 tentatives
          });
          _showErrorDialog(context,
              'Vous avez fait plusieurs tentatives infructueuses. Accès refusé.');
        } else {
          _showErrorDialog(
              context, 'Identifiants incorrects. Veuillez réessayer.');
        }
      }
    } else {
      _showErrorDialog(
          context, 'Erreur de connexion. Veuillez réessayer plus tard.');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Erreur de connexion'),
          content: Text(message),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/photo.png",
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
                    ),
                    _buildLoginForm(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 50),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * 0.2),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 1).withOpacity(_opacity),
                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                ),
                width: MediaQuery.of(context).size.width * 0.9,
                child: Form(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Opérateur d'urgence",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: emailController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade800),
                              ),
                              label: const Text(
                                'Email',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintText: 'Votre email',
                              errorText: _attempts >= 3
                                  ? 'Tentatives multiples échouées'
                                  : null,
                            ),
                            enabled: !_fieldsDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextField(
                            controller: passwordController,
                            cursorColor: Colors.black,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade800),
                              ),
                              label: const Text(
                                'Mot de passe',
                                style: TextStyle(color: Colors.black),
                              ),
                              hintText: 'Votre mot de passe',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                              errorText: _attempts >= 3
                                  ? 'Tentatives multiples échouées'
                                  : null,
                            ),
                            enabled: !_fieldsDisabled,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: GestureDetector(
                            onTap: loginUser,
                            child: Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 43, 130, 201),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Se Connecter'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
