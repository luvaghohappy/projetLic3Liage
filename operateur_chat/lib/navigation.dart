import 'package:flutter/material.dart';
import 'package:operateur_chat/home.dart';
import 'compte.dart';

class NaviagtionPage extends StatefulWidget {
  NaviagtionPage({super.key});

  @override
  State<NaviagtionPage> createState() => _NaviagtionPageState();
}

class _NaviagtionPageState extends State<NaviagtionPage> {
  int currentindex = 0; // Définir à 1 pour afficher "Secours" en premier

  List<Widget> screen = [
    const Myhomepage(),
    MonComptePage(),
  ];

  void _listbotton(int index) {
    setState(() {
      currentindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2E33),
      body: screen[
          currentindex], // Afficher l'écran en fonction de l'index actuel
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.black,
        currentIndex: currentindex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            currentindex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 20,
            ),
            label: 'Mon compte',
          ),
        ],
      ),
    );
  }
}
