// import 'package:flutter/material.dart';

// class HistoriqueAppel extends StatefulWidget {
//   const HistoriqueAppel({super.key});

//   @override
//   State<HistoriqueAppel> createState() => _HistoriqueAppelState();
// }

// class _HistoriqueAppelState extends State<HistoriqueAppel> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }


// // import 'package:flutter/material.dart';
// //  drawer: Drawer(
// //         child: ListView(
// //           children: [
// //             DrawerHeader(
// //               child: Center(
// //                 child: Column(
// //                   children: [
// //                     Image.asset(
// //                       'assets/viesauve.webp',
// //                       width: 300,
// //                       height: 130,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),
// //             ListTile(
// //               onTap: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const Mapspage(),
// //                 ));
// //               },
// //               leading: const Icon(Icons.location_pin),
// //               title: const Text('Maps'),
// //             ),
// //             ListTile(
// //               onTap: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const NosPostes(),
// //                 ));
// //               },
// //               leading: const Icon(Icons.local_police_sharp),
// //               title: const Text('Nos Postes'),
// //             ),
// //             ListTile(
// //               onTap: () {
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const HistoriqueAppel(),
// //                 ));
// //               },
// //               leading: const Icon(Icons.call),
// //               title: const Text('Historiques Appels'),
// //             ),
// //             const Padding(padding: EdgeInsets.only(top: 250)),
// //             ListTile(
// //               onTap: () {
// //                 logoutUser(email, context);
// //                 Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const Menu(),
// //                 ));
// //               },
// //               leading: const Icon(Icons.app_blocking_outlined),
// //               title: const Text('Deconnexion'),
// //             ),
// //           ],
// //         ),
// //       ),



// // class Mymainpage extends StatelessWidget {
// //   const Mymainpage({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Expanded(
// //               child: _buildContainer(context),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   static Container _buildContainer(BuildContext context) {
// //     final h = MediaQuery.of(context).size.height;
// //     return Container(
// //       height: h,
// //       width: 200,
// //       margin: const EdgeInsets.all(8.0), // Ajouter des marges autour du container
// //       decoration: BoxDecoration(
// //         border: const Border(
// //           top: BorderSide(color: Colors.black),
// //           right: BorderSide(color: Colors.black),
// //           bottom: BorderSide(color: Colors.black),
// //         ),
// //         borderRadius: BorderRadius.circular(5),
// //       ),
// //       child: Column(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           const SizedBox(height: 20), // Utilisation de SizedBox pour les espacements
// //           Padding(
// //             padding: const EdgeInsets.only(left: 30),
// //             child: Image.asset(
// //               'assets/viesauve.webp',
// //               width: 70,
// //               height: 50,
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           const Padding(
// //             padding: EdgeInsets.only(left: 40),
// //             child: Text(
// //               'VIE SAUVE',
// //               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
// //             ),
// //           ),
// //           const SizedBox(height: 100),
// //           ListTile(
// //             leading: const Icon(Icons.home),
// //             title: TextButton(
// //               onPressed: () {},
// //               child: const Text(
// //                 'DashBoard',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           ListTile(
// //             leading: const Icon(Icons.location_pin),
// //             title: TextButton(
// //               onPressed: () {
// //                 //  Navigator.of(context).push(MaterialPageRoute(
// //                 //   builder: (context) => const Mapspage(),
// //                 // ));
// //               },
// //               child: const Text(
// //                 'Maps',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           ListTile(
// //             leading: const Icon(Icons.local_police_sharp),
// //             title: TextButton(
// //               onPressed: () {
// //                   Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const NosPostes(),
// //                 ));
// //               },
// //               child: const Text(
// //                 'Maps Postes',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 20),
// //           ListTile(
// //             leading: const Icon(Icons.call),
// //             title: TextButton(
// //               onPressed: () {
// //                  Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const HistoriqueAppel(),
// //                 ));
// //               },
// //               child: const Text(
// //                 'Historiques Appels',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           ),
// //           const SizedBox(height: 220),
// //           ListTile(
// //             leading: const Icon(Icons.app_blocking_outlined),
// //             title: TextButton(
// //               onPressed: () {
// //                  Navigator.of(context).push(MaterialPageRoute(
// //                   builder: (context) => const Menu(),
// //                 ));
// //               },
// //               child: const Text(
// //                 'Deconnexion',
// //                 style: TextStyle(fontSize: 16),
// //               ),
// //             ),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// // }



// //  // Utilisez FutureBuilder pour attendre que la carte soit initialisée
// //                   FutureBuilder<web.GoogleMapController>(
// //                     future: _initializeMap(),
// //                     builder: (context, snapshot) {
// //                       if (snapshot.connectionState == ConnectionState.waiting) {
// //                         return const CircularProgressIndicator(); 
// //                       } else {
// //                         return Expanded(
// //                           child: GoogleMap(
// //                             initialCameraPosition: const CameraPosition(
// //                               target: LatLng(37.7749,
// //                                   -122.4194), // Coordonnées du centre de la carte
// //                               zoom: 12, // Niveau de zoom initial
// //                             ),
// //                             mapType: MapType.normal, // Type de carte
// //                             onMapCreated: (controller) {
// //                               // Ajouter des marqueurs ou effectuer d'autres opérations avec le contrôleur ici
// //                             },
// //                           ),
// //                         );
// //                       }
// //                     },
// //                   ),




//   // Future<web.GoogleMapController> _initializeMap() async {
//   //   // Créer un stream controller
//   //   final streamController = StreamController<web.GMapEvent>.broadcast();
//   //   // Créer un widget configuration
//   //   final widgetConfiguration = web.WidgetConfiguration(
//   //     createMarkerWriter: () => web.MarkerWriter(),
//   //     createPolylineWriter: () => web.PolylineWriter(),
//   //     createPolygonWriter: () => web.PolygonWriter(),
//   //     createCircleWriter: () => web.CircleWriter(),
//   //     createTileOverlayWriter: () => web.TileOverlayWriter(),
//   //   );
//   //   // Créer un contrôleur de carte en l'initialisant avec un identifiant de carte unique, un stream controller et un widget configuration
//   //   final controller = web.GoogleMapController(
//   //     mapId: web.MapId("your_map_id"), // Remplacez "your_map_id" par un identifiant de carte unique
//   //     streamController: streamController,
//   //     widgetConfiguration: widgetConfiguration,
//   //   );
//   //   // Attendre que le contrôleur de carte soit prêt
//   //   await controller.ready;
//   //   return controller;
//   // }





