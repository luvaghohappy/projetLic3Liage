import 'package:flutter/material.dart';

class SOS extends StatefulWidget {
  const SOS({super.key});

  @override
  State<SOS> createState() => _SOSState();
}

class _SOSState extends State<SOS> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
          ),
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
          const Text("Appeler nos services d'urgence en tout moment"),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                  elevation: 10,
                ),
                child: const Text(
                  'SOS AMBULANCE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                  elevation: 10,
                ),
                child: const Text(
                  'SOS POLICE',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(30),
                  elevation: 10,
                ),
                child: const Text(
                  'SOS POMPIER',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Action à effectuer lors de l'appui sur le bouton
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(50),
                  elevation: 10,
                ),
                child: const Text(
                  'NOTIFICATIONS',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
