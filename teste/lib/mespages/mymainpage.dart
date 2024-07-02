// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:charts_flutter/flutter.dart' as charts;
// import 'package:http/http.dart' as http;
// import 'package:projettutore/login/menu.dart';
// import 'package:projettutore/mespages/poste.dart';
// import 'historique.dart';


// class MonthData {
//   final String month;
//   final int value;

//   MonthData(this.month, this.value);
// }

// class Mymainpage extends StatelessWidget {
//   final String email;
//   final String profil;

//   Mymainpage({Key? key, required this.email, required this.profil})
//       : super(key: key);

//   Future<void> logoutUser(String email, BuildContext context) async {
//     final url = 'http://192.168.43.148:81/projetSV/selectUser.php';
//     final response = await http.post(
//       Uri.parse(url),
//       body: {
//         'email': email,
//       },
//     );

//     if (response.statusCode == 200) {
//       final responseData = json.decode(response.body);
//       if (responseData['success']) {
//         // Déconnexion réussie, revenir à l'écran de connexion
//         Navigator.pop(context);
//       } else {
//         // Gérer les erreurs de déconnexion
//         showDialog(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               title: const Text('Erreur'),
//               content: Text(responseData['message']),
//               actions: [
//                 TextButton(
//                   onPressed: () => Navigator.pop(context),
//                   child: const Text('OK'),
//                 ),
//               ],
//             );
//           },
//         );
//       }
//     } else {
//       // Gérer les erreurs de connexion
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text('Erreur'),
//             content: const Text(
//                 'Erreur lors de la déconnexion. Veuillez réessayer plus tard.'),
//             actions: [
//               TextButton(
//                 onPressed: () => Navigator.pop(context),
//                 child: const Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   List<charts.Series<MonthData, String>> _createSampleData() {
//     return [
//       charts.Series<MonthData, String>(
//         id: 'Mois',
//         domainFn: (MonthData month, _) => month.month,
//         measureFn: (MonthData month, _) => month.value,
//         data: data,
//       ),
//     ];
//   }

//   final List<MonthData> data = [
//     MonthData('Jan', 100),
//     MonthData('Feb', 150),
//     MonthData('Mar', 200),
//     MonthData('Apr', 180),
//     MonthData('May', 220),
//     MonthData('Jun', 250),
//     MonthData('Jul', 300),
//     MonthData('Aug', 350),
//     MonthData('Sep', 400),
//     MonthData('Nov', 450),
//     MonthData('Dec', 500),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               Container(
//                 height: h * 2,
//                 width: 200,
//                 margin: const EdgeInsets.all(8.0),
//                 decoration: BoxDecoration(
//                   color: Colors
//                       .grey, // Remplacer la bordure par une couleur de fond grise
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                         height:
//                             20), // Utilisation de SizedBox pour les espacements
//                     Padding(
//                       padding: const EdgeInsets.only(left: 30),
//                       child: Image.asset(
//                         'assets/viesauve.webp', // Charger l'image au format WebP
//                         width: 100,
//                         height: 50,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     const Padding(
//                       padding: EdgeInsets.only(left: 40),
//                       child: Text(
//                         'VIE SAUVE',
//                         style:
//                             TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                     ),
//                     const SizedBox(height: 100),
//                     ListTile(
//                       leading: const Icon(Icons.home),
//                       title: TextButton(
//                         onPressed: () {},
//                         child: const Text(
//                           'DashBoard',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ListTile(
//                       leading: const Icon(Icons.location_pin),
//                       title: TextButton(
//                         onPressed: () {
//                           //  Navigator.of(context).push(MaterialPageRoute(
//                           //   builder: (context) => const Mapspage(),
//                           // ));
//                         },
//                         child: const Text(
//                           'Maps',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ListTile(
//                       leading: const Icon(Icons.local_police_sharp),
//                       title: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const NosPostes(),
//                           ));
//                         },
//                         child: const Text(
//                           'Maps Postes',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     ListTile(
//                       leading: const Icon(Icons.call),
//                       title: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const HistoriqueAppel(),
//                           ));
//                         },
//                         child: const Text(
//                           'Historiques Appels',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 220),
//                     ListTile(
//                       leading: const Icon(Icons.app_blocking_outlined),
//                       title: TextButton(
//                         onPressed: () {
//                           Navigator.of(context).push(MaterialPageRoute(
//                             builder: (context) => const Menu(),
//                           ));
//                         },
//                         child: const Text(
//                           'Deconnexion',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Column(
//                 children: [
//                   Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 20,
//                         backgroundImage: MemoryImage(base64Decode(profil)),
//                       ),
//                       const Padding(padding: EdgeInsets.only(left: 10)),
//                       Text(
//                         'Operateur: $email',
//                         style: const TextStyle(fontSize: 18, color: Colors.black),
//                       ),
//                     ],
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 60)),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 300),
//                     child: Row(
//                       children: [
//                         Column(
//                           children: [
//                             const Text('Nombre Appels'),
//                             const Padding(
//                               padding: EdgeInsets.only(top: 20),
//                             ),
//                             Container(
//                               height: 170,
//                               width: 300,
//                               child: Card(
//                                 color: Colors.white.withOpacity(0.1),
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(20.0),
//                                   child: Center(
//                                     child: Text(
//                                       '1234',
//                                       style: TextStyle(fontSize: 20.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(left: 50),
//                         ),
//                         Column(
//                           children: [
//                             const Text('Nombre Postes'),
//                             const Padding(
//                               padding: EdgeInsets.only(top: 20),
//                             ),
//                             Container(
//                               height: 170,
//                               width: 300,
//                               child: Card(
//                                 color: Colors.white.withOpacity(0.1),
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(20.0),
//                                   child: Center(
//                                     child: Text(
//                                       '1234',
//                                       style: TextStyle(fontSize: 20.0),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   const Padding(padding: EdgeInsets.only(top: 50)),
//                   Container(
//                     width: 900,
//                     height: 600,
//                     child: charts.BarChart(
//                       _createSampleData(),
//                       animate: true,
//                     ),
//                   ),
//                   const Padding(
//                     padding: EdgeInsets.only(top: 30),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
