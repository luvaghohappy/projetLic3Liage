import 'dart:convert';
import 'package:admin/login/login.dart';
import 'package:admin/pagesAdmin/historiques.dart';
import 'package:flutter/material.dart';
import 'pagesAdmin/postes.dart';
import 'pagesAdmin/user.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class MonthData {
  final String month;
  final int value;

  MonthData(this.month, this.value);
}

class HomaPage extends StatefulWidget {
  final String email;
  final String profil;

  const HomaPage({Key? key, required this.email, required this.profil})
      : super(key: key);

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
 List<charts.Series<MonthData, String>> _createSampleData() {
    return [
      charts.Series<MonthData, String>(
        id: 'Mois',
        domainFn: (MonthData month, _) => month.month,
        measureFn: (MonthData month, _) => month.value,
        data: data,
      ),
    ];
  }

  final List<MonthData> data = [
    MonthData('Jan', 100),
    MonthData('Feb', 150),
    MonthData('Mar', 200),
    MonthData('Apr', 180),
    MonthData('May', 220),
    MonthData('Jun', 250),
    MonthData('Jul', 300),
    MonthData('Aug', 350),
    MonthData('Sep', 400),
    MonthData('Nov', 450),
    MonthData('Dec', 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'VIE SAUVE',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: MemoryImage(base64Decode(widget.profil)),
              ),
              const Padding(padding: EdgeInsets.only(left: 10)),
              Text(
                'Email: ${widget.email}',
                style: const TextStyle(fontSize: 18, color: Colors.white),
              ),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/viesauve.webp',
                      width: 300,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Users2(),
                ));
              },
              leading: const Icon(Icons.support_agent),
              title: const Text('Operateurs'),
            ),
             ListTile(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Postes(),
                ));
              },
              leading: const Icon(Icons.local_police_sharp),
              title: const Text('Postes'),
            ),
             ListTile(
              onTap: () {
                 Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Historique(),
                ));
              },
              leading: const Icon(Icons.work_history),
              title: const Text('Historiques'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 310),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Mylogin(),
                ));
              },
              leading: const Icon(Icons.app_blocking_outlined),
              title: const Text('Deconnexion'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
              const Padding(padding: EdgeInsets.only(top: 60)),
                    Padding(
                      padding: const EdgeInsets.only(left: 300),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              const Text('Nombre Appels'),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Container(
                                height: 170,
                                width: 300,
                                child: Card(
                                  color: Colors.white.withOpacity(0.1),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        '1234',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 50),
                          ),
                          Column(
                            children: [
                              const Text('Nombre Postes'),
                              const Padding(
                                padding: EdgeInsets.only(top: 20),
                              ),
                              Container(
                                height: 170,
                                width: 300,
                                child: Card(
                                  color: Colors.white.withOpacity(0.1),
                                  child: const Padding(
                                    padding: EdgeInsets.all(20.0),
                                    child: Center(
                                      child: Text(
                                        '1234',
                                        style: TextStyle(fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    Container(
                      width: 900,
                      height: 600,
                      child: charts.BarChart(
                        _createSampleData(),
                        animate: true,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 30),
                    ),
                  ],
                ),
      ),
            );
          
     
  }
}
