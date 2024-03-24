import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:projettutore/login/navigation.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  bool inLoginProcess = false;

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        "https://static1.anpoimages.com/wordpress/wp-content/uploads/2022/07/googleMapsTricksHero.jpg",
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        fit: BoxFit.cover,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height * 0.2),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.26),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: _sigmaX, sigmaY: _sigmaY),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1.0),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 1)
                                        .withOpacity(_opacity),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(30))),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.4,
                                child: Form(
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          "Operateur d'urgence",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                              fontSize: 20),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: emailController,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              label: const Text(
                                                'Email',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              hintText: 'Votre email',
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: TextField(
                                            controller: passwordController,
                                            obscureText: true,
                                            decoration: InputDecoration(
                                              enabledBorder:
                                                  const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.white),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color:
                                                        Colors.grey.shade400),
                                              ),
                                              label: const Text(
                                                'Password',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              hintText: 'Votre password',
                                            ),
                                          ),
                                        ),
                                        const Padding(
                                            padding: EdgeInsets.only(top: 30)),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.of(context)
                                                .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  NaviagtionPage(),
                                            ));
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            decoration: BoxDecoration(
                                              color: const Color.fromARGB(
                                                  255, 43, 130, 201),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                                child: Text('Se Connecter')),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
