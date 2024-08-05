import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:operateur/admin/historique.dart';
import 'package:operateur/admin/login.dart';
import 'package:operateur/admin/victime.dart';
import 'package:operateur/menu.dart';
import 'operateur.dart';

class Myfirstpage extends StatefulWidget {
  const Myfirstpage({Key? key}) : super(key: key);

  @override
  State<Myfirstpage> createState() => _MyfirstpageState();
}

class _MyfirstpageState extends State<Myfirstpage> {
  List<Map<String, dynamic>> items = [];
  List<TableInfo> tableInfoList = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(
        Uri.parse("http://192.168.43.148:81/projetSV/state.php"),
      );
      setState(() {
        items = List<Map<String, dynamic>>.from(json.decode(response.body));
        tableInfoList = items
            .map((item) => TableInfo(
                  tableName: item['table_names'],
                  recordCount: int.parse(item['record_count']),
                ))
            .toList();
      });
    } catch (e) {
      print('Error fetching data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load items'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'Statistiques des activites',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/logo.jpg',
                      width: 300,
                      height: 130,
                    ),
                  ],
                ),
              ),
            ),
           
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Users2(),
                ));
              },
              leading: const Icon(
                Icons.support_agent,
                color: Colors.green,
              ),
              title: const Text('Operateurs'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Historique(),
                ));
              },
              leading: const Icon(
                Icons.work_history_outlined,
                color: Color.fromARGB(255, 201, 124, 23),
              ),
              title: const Text('Historiques'),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 310),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const Menu(),
                ));
              },
              leading: const Icon(
                Icons.login_outlined,
                color: Colors.red,
              ),
              title: const Text('Deconnexion'),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: showingSections(),
                        centerSpaceRadius: 40,
                        sectionsSpace: 0,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: tableInfoList.asMap().entries.map((entry) {
                      final int index = entry.key;
                      final TableInfo tableInfo = entry.value;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Indicator(
                          color:
                              Colors.primaries[index % Colors.primaries.length],
                          text: tableInfo.tableName,
                          isSquare: true,
                          size: 18, // Adjust size as needed
                          textColor: Colors.black,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            for (var tableInfo in tableInfoList)
              _buildStatisticsCard(tableInfo.tableName, tableInfo.recordCount),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return tableInfoList.asMap().entries.map((entry) {
      final int index = entry.key;
      final TableInfo tableInfo = entry.value;
      final isTouched = index == -1; // Update this logic as needed
      final double fontSize = isTouched ? 25.0 : 16.0;
      final double radius = isTouched ? 60.0 : 50.0;

      return PieChartSectionData(
        color: Colors
            .primaries[index % Colors.primaries.length], // Cycle through colors
        value: tableInfo.recordCount.toDouble(),
        title: '${tableInfo.recordCount}',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }).toList();
  }

  Widget _buildStatisticsCard(String title, int count) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(count.toString()),
      ),
    );
  }
}

class TableInfo {
  final String tableName;
  final int recordCount;

  TableInfo({
    required this.tableName,
    required this.recordCount,
  });
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color textColor;

  const Indicator({
    Key? key,
    required this.color,
    required this.text,
    this.isSquare = false,
    this.size = 16,
    this.textColor = const Color(0xff505050),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
