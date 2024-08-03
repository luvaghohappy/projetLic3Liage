import 'package:flutter/material.dart';
import 'package:operateur_chat/home.dart';
import 'package:operateur_chat/navigation.dart';
import 'login.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({Key? key}) : super(key: key);

  @override
  State<Myfirstpage> createState() => _MyfirstpageState();
}

class _MyfirstpageState extends State<Myfirstpage> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://th.bing.com/th/id/R.abac061fc318d1803385a9b87b4f7250?rik=y2zKmoYsLT%2fdTg&pid=ImgRaw&r=0'),
                fit: BoxFit.cover,
              ),
            ),
            child: Opacity(
              opacity: 0.2,
              child: Container(
                color: Colors.black,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350),
            child: Center(
              child: Container(
                height: h * 0.4,
                width: w,
                decoration: const BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Operateur ",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyForm(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Creer un compte',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NaviagtionPage(),
                          ),
                        );
                      },
                      child: Container(
                        height: 50,
                        width: 220,
                        decoration: BoxDecoration(
                          color: Colors.deepPurple,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Se connecter',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
