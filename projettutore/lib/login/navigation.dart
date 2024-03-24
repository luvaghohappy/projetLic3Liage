import 'package:flutter/material.dart';
import 'package:projettutore/homepage.dart';
import 'package:projettutore/mespages/historique.dart';
import 'package:projettutore/mespages/maps.dart';
import 'package:projettutore/mespages/poste.dart';

class NaviagtionPage extends StatefulWidget {
    NaviagtionPage({super.key});

  @override
  State<NaviagtionPage> createState() => _NaviagtionPageState();
}

class _NaviagtionPageState extends State<NaviagtionPage> {
  @override
  int currentindex = 0;
  List<Widget> screen =   [
    const Homepage(),
     const Mapspage(),
    const NosPostes(),
    const HistoriqueAppel(),
   
  ];
  void _listbotton(int index) {
    currentindex = index;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2D2E33),
   

      body: Container(),
      bottomSheet: screen[currentindex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedItemColor: Colors.amber,
          unselectedItemColor: Colors.grey,
          currentIndex: currentindex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              currentindex = index;
            });
          },
          items:const [
            BottomNavigationBarItem(
              icon: Icon(
                (Icons.home),
                size: 20,
              ),
              label: 'Dashboard',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                (Icons.location_pin),
                size: 20,
              ),
              label: 'Maps',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                (Icons.local_police_sharp),
                size: 20,
              ),
              label: 'Nos Postes',
            ),
             BottomNavigationBarItem(
              icon: Icon(
                (Icons.call),
                size: 20,
              ),
              label: 'Historiques Appels',
            ),
          ]),
    );
  }
}
