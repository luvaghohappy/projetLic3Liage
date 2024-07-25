import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vie_sauve/login.dart';
import 'compte.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: h * 0.1,
              width: w,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Image(
                      image: NetworkImage(
                          'https://th.bing.com/th/id/R.1795a11ae9ef950b1cbde32e81203325?rik=EGRpHCpjBg0LHw&pid=ImgRaw&r=0'),
                      height: 30,
                      width: 60,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 140),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundImage: NetworkImage(
                        'https://th.bing.com/th/id/R.c11b6f38dffc24a4508217513b0e50bd?rik=gu0HLGdqJNF5Rg&pid=ImgRaw&r=0',
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Text('Prenom')
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: PopupMenuButton<String>(
                splashRadius: 10,
                color: Colors.white,
                child: Row(
                  children: const [
                    Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                    ),
                    Text('Mon Compte')
                  ],
                ),
                onSelected: (String result) {
                  if (result == 'create_account') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyForm(),
                      ),
                    );
                  } else if (result == 'account') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Moncompte(),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    value: 'create_account',
                    child: Row(
                      children: const [
                        Icon(Icons.create, size: 15),
                        SizedBox(width: 10),
                        Text(
                          'Creer un compte',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'account',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.verified_user_outlined,
                          size: 15,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Compte',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'A propos de VIE-SAUVE',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "VIE-SAUVE Est une application innovante conçue pour améliorer les interventions d'urgence en cas de situations de sécurité et de sauvetage. Elle permet aux utilisateurs de signaler rapidement des incidents, de partager leur localisation en temps réel avec les services d'urgence et de recevoir des instructions vitales en attendant l'arrivée des secours.",
                    style: GoogleFonts.abel(),
                  ),
                  const Text(
                    'Objectif :',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    " Améliorer la rapidité et l'efficacité des interventions d'urgence, réduire les délais de réponse et offrir une tranquillité d'esprit aux utilisateurs en leur fournissant un outil fiable pour signaler et gérer les situations d'urgence.",
                    style: GoogleFonts.abel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),
                  const Text(
                    'Nos Services',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AMBULANCE',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Les ambulanciers sont souvent parmi les premiers à arriver sur les lieux d'une urgence médicale, prêts à fournir des soins immédiats.",
                    style: GoogleFonts.abel(),
                  ),
                  Text(
                    "Ils effectuent une évaluation rapide de l'état du patient pour déterminer la nature et la gravité de l'urgence.",
                    style: GoogleFonts.abel(),
                  ),
                  Text(
                    "Les ambulanciers administrent des premiers soins essentiels tels que la réanimation cardio-pulmonaire (RCP), l'arrêt des saignements, et la gestion des voies respiratoires.",
                    style: GoogleFonts.abel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),

                  // Section Police
                  const Text(
                    'POLICE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Les agents de police sont souvent les premiers intervenants sur les lieux d'un incident. Leur arrivée rapide est essentielle pour évaluer la situation et initier les premières actions nécessaires.",
                    style: GoogleFonts.abel(),
                  ),
                  Text(
                    "Ils établissent un périmètre de sécurité pour protéger les victimes, les témoins et empêcher l'accès non autorisé. Cela permet aux autres services d'urgence de travailler en toute sécurité.",
                    style: GoogleFonts.abel(),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 20),
                  ),

                  // Section Pompier
                  const Text(
                    'POMPIER',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                  ),
                  Text(
                    "Les pompiers se déploient rapidement pour éteindre les incendies et empêcher leur propagation.",
                    style: GoogleFonts.abel(),
                  ),
                  Text(
                    "Ils utilisent diverses techniques et équipements spécialisés pour combattre les feux de différentes natures (feux de structure, de forêt, de véhicules, etc.).",
                    style: GoogleFonts.abel(),
                  ),
                  Text(
                    'Les pompiers effectuent des opérations de recherche pour localiser et secourir les personnes piégées dans des bâtiments en feu, des véhicules accidentés ou des zones dangereuses.',
                    style: GoogleFonts.abel(),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              height: 250,
              width: double.infinity,
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    setState(() {
                      // Update the state if necessary
                    });
                  },
                ),
                items: images.map((imageUrl) {
                  return Container(
                    margin: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10.0)),
                      child: Stack(
                        children: <Widget>[
                          Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: 1000.0,
                          ),
                          Positioned(
                            bottom: 0.0,
                            left: 0.0,
                            right: 0.0,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(200, 0, 0, 0),
                                    Color.fromARGB(0, 0, 0, 0)
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                ),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 20.0),
                              child: const Text(
                                'Services Urgence',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Container(
              height: 40,
              width: double.infinity,
              color: Colors.white,
              child: const Center(
                child: Text(
                  '@Copyright VIE-SAUVE 2024',
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
