import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vie_sauve/menu/apropos.dart';
import 'package:vie_sauve/menu/guide.dart';
import 'package:vie_sauve/menu/settings.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? imagePath;
  String? prenom;
  List<Map<String, dynamic>> items = [];

  final List<String> images = [
    'https://th.bing.com/th/id/R.41ae108aba96327a5f1d7305ba167ec7?rik=TwSPsRyHW97KcA&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.abad49c504fe7f1e74ed428cb9cda6a6?rik=L6Y8myr7P5jGAA&riu=http%3a%2f%2foise-media.fr%2fwp-content%2fuploads%2f2019%2f04%2fSDIS-2.jpg&ehk=37AZpKjFZD36BVWcKpx7RpShUq60Bj2heAiA%2fpW2%2fLU%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.abd5b632ad50817a159c6817a5971030?rik=uIHa7fvZHBELbA&riu=http%3a%2f%2fi.ytimg.com%2fvi%2fhCzQdiUT1HI%2fmaxresdefault.jpg&ehk=GjrnTHzHPFDPG5v7HIbZbsF0RqgOG%2btdjSjGtc9QEP0%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/R.4aea793fa245a81089f025d4e1b374e3?rik=H7TrDAEgrZNTew&riu=http%3a%2f%2fwww.coursonlescarrieres.fr%2fwp-content%2fuploads%2f2013%2f06%2f508-BIS.jpg&ehk=u6RFfvqnIsmagZn48IqhBJ88KbVvjqdp%2fRffJ7IlfQo%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.SJlodOEQCpV6LYM0L1bS2gHaFT?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/R.d322c57e2007d3060ac99990929e20c0?rik=vgVVHOMeSY%2b7QQ&riu=http%3a%2f%2fi.ytimg.com%2fvi%2fvi9fhNwd5QI%2fmaxresdefault.jpg&ehk=7pyCcAlVdjMYMw9xvnnCBnDkOG8bNkyzSmsbH5ip%2b2Y%3d&risl=&pid=ImgRaw&r=0',
    'https://th.bing.com/th/id/OIP.YAtdXWceaPfmnat3f8CbrQHaFy?rs=1&pid=ImgDetMain',
    'https://th.bing.com/th/id/R.eaa7a625258287b3eadfd9ef57c82bf1?rik=7s3BwYdPgYDO7Q&pid=ImgRaw&r=0',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prenom = prefs.getString('prenom');
      imagePath = prefs.getString('image_path');
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = items.isNotEmpty ? items[0] : {};
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    // Vérifiez et construisez l'URL de l'image
    final imageUrl = imagePath != null
        ? "http://192.168.43.148:81/projetSV/$imagePath"
        : null;
    print('Image URL: $imageUrl');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Image.asset(
          'assets/logo.jpg',
          height: 40,
          width: 60,
        ),
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
            backgroundColor: Colors.grey,
            child: imageUrl == null ? const Icon(Icons.person, size: 15) : null,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 5),
          ),
          Center(
            child: Text(
              prenom ?? '',
              style: const TextStyle(color: Colors.black),
            ),
          ),
          PopupMenuButton<int>(
            icon: const Icon(
              Icons.more_vert_outlined,
              color: Colors.black,
            ),
            onSelected: (value) {
              switch (value) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Settings(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Guides(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Apropos(),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              PopupMenuItem<int>(
                value: 0,
                child: Row(
                  children: const [
                    Icon(Icons.settings, size: 15, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Paramètres'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.book, size: 15, color: Colors.black),
                    SizedBox(width: 8),
                    Text('Guide'),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.info, size: 15, color: Colors.black),
                    SizedBox(width: 8),
                    Text('À propos'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'I. A propos de VIE-SAUVE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "VIE-SAUVE Est une application innovante conçue pour améliorer les interventions d'urgence en cas de situations de sécurité et de sauvetage. Elle permet aux utilisateurs de signaler rapidement des incidents, de partager leur localisation en temps réel avec les services d'urgence et de recevoir des instructions vitales en attendant l'arrivée des secours.",
                    style: GoogleFonts.abel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Text(
                    'II. Objectif :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    " Améliorer la rapidité et l'efficacité des interventions d'urgence, réduire les délais de réponse et offrir une tranquillité d'esprit aux utilisateurs en leur fournissant un outil fiable pour signaler et gérer les situations d'urgence.",
                    style: GoogleFonts.abel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  const Text(
                    'III. Nos Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              height: h * 0.4,
              width: w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/logo.jpg'), fit: BoxFit.cover),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '1. Localisation des appels d’urgence:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/appel.png',
                        height: 70,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "La fonction de localisation des appels d'urgence permet de déterminer avec précision la position géographique des appelants en détresse. Grâce à la géolocalisation en temps réel, les services d'urgence peuvent localiser rapidement les utilisateurs et envoyer les secours appropriés à l'endroit exact.",
                          style: GoogleFonts.abel(),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Text(
                    '2. Assistance médicale à distance:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/soin.png',
                        height: 70,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "En attendant l'arrivée des secours, VIE-SAUVE offre une assistance médicale à distance. Les utilisateurs peuvent recevoir des instructions vitales, des conseils sur les premiers secours et des indications sur les mesures à prendre en cas d'urgence médicale.",
                          style: GoogleFonts.abel(),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Text(
                    '3. Répertoire des contacts d’urgence:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/numero.png',
                        height: 70,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "L'application permet aux utilisateurs de créer un répertoire personnalisé de contacts d'urgence, comprenant des membres de la famille, des amis proches et des professionnels de la santé. En cas de besoin, les utilisateurs peuvent rapidement informer leurs contacts d'urgence de leur situation.",
                          style: GoogleFonts.abel(),
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  const Text(
                    '4. Historique des incidents:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/histoire.png',
                        height: 70,
                        width: 60,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "VIE-SAUVE conserve un historique détaillé des incidents signalés par les utilisateurs. Cela permet aux utilisateurs de consulter leurs rapports d'urgence passés, de suivre l'évolution de chaque incident et de partager les informations avec les autorités compétentes si nécessaire.",
                          style: GoogleFonts.abel(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2,
              indent: 20,
              endIndent: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Nous croyons fermement que VIE-SAUVE sera un outil précieux pour renforcer la sécurité et le sauvetage dans notre communauté, en permettant des interventions plus rapides, une assistance médicale à distance efficace et une tranquillité d'esprit pour nos utilisateurs.",
                  style: GoogleFonts.abel(),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            CarouselSlider(
              items: images.map((imageUrl) {
                return Container(
                  margin: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
          ],
        ),
      ),
    );
  }
}
