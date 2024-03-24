import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class MonthData {
  final String month;
  final int value;

  MonthData(this.month, this.value);
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: 130,
                    child: Image.network(
                        'https://i0.wp.com/www.egem.tn/wp-content/uploads/2018/01/Intervention-rapide.png?fit=640%2C561&ssl=1'),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 300),
                  ),
                  const Text(
                    'VIE SAUVE',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 200),
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        'https://cdn-icons-png.flaticon.com/512/2966/2966486.png'),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 10)),
                  const Text('Operateur1'),
                ],
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 30)),
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
                          color: Colors.white.withOpacity(
                              0.1), // Opacité ajustée ici (par exemple)
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
                          color: Colors.white.withOpacity(
                              0.1), // Opacité ajustée ici (par exemple)
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
