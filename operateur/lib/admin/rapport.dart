// import 'package:flutter/material.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// // import 'dart:html' as html;
// // import 'package:pdf/pdf.dart';
// // import 'package:pdf/widgets.dart' as pw;

// class Rapports extends StatefulWidget {
//   const Rapports({super.key});

//   @override
//   State<Rapports> createState() => _RapportsState();
// }

// class _RapportsState extends State<Rapports> {
//   List<Map<String, dynamic>> items = [];
//   List<Map<String, dynamic>> filteredItems = [];
//   String searchQuery = '';
//   DateTime? startDate;
//   DateTime? endDate;

//   Future<void> fetchData() async {
//     try {
//       final response = await http.get(
//         Uri.parse("http://192.168.43.148:81/projetSV/rapport.php"),
//       );

//       setState(() {
//         items = List<Map<String, dynamic>>.from(json.decode(response.body));
//         filteredItems = items;
//       });
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('Failed to load items'),
//         ),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Load initial data when the app starts
//   }

//   void _filterItems() {
//     setState(() {
//       filteredItems = items.where((user) {
//         final userDate = DateTime.tryParse(user['created_at'] ?? '');
//         final service = user['service']?.toLowerCase() ?? '';

//         bool matchesService = service.contains(searchQuery.toLowerCase());
//         bool matchesDate = true;

//         if (startDate != null && endDate != null && userDate != null) {
//           matchesDate =
//               userDate.isAfter(startDate!) && userDate.isBefore(endDate!);
//         }

//         return matchesService && matchesDate;
//       }).toList();
//     });
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTimeRange? picked = await showDateRangePicker(
//       context: context,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null &&
//         picked !=
//             DateTimeRange(
//                 start: startDate ?? DateTime.now(),
//                 end: endDate ?? DateTime.now())) {
//       setState(() {
//         startDate = picked.start;
//         endDate = picked.end;
//       });
//       _filterItems();
//     }
//   }

//   // void _generatePdf() async {
//   //   final pdf = pw.Document();

//   //   pdf.addPage(
//   //     pw.Page(
//   //       build: (pw.Context context) {
//   //         return pw.Column(
//   //           crossAxisAlignment: pw.CrossAxisAlignment.start,
//   //           children: [
//   //             pw.Text('Rapport',
//   //                 style: pw.TextStyle(
//   //                     fontSize: 24, fontWeight: pw.FontWeight.bold)),
//   //             pw.SizedBox(height: 20),
//   //             pw.Table.fromTextArray(
//   //               headers: [
//   //                 'Nom',
//   //                 'Postnom',
//   //                 'Prenom',
//   //                 'Sexe',
//   //                 'Locations',
//   //                 'Date_Heure',
//   //                 'Services'
//   //               ],
//   //               data: filteredItems.map((item) {
//   //                 return [
//   //                   item['nom'] ?? '',
//   //                   item['postnom'] ?? '',
//   //                   item['prenom'] ?? '',
//   //                   item['sexe'] ?? '',
//   //                   item['locations'] ?? '',
//   //                   item['created_at'] ?? '',
//   //                   item['service'] ?? '',
//   //                 ];
//   //               }).toList(),
//   //             ),
//   //           ],
//   //         );
//   //       },
//   //     ),
//   //   );

//   //   // Convert the PDF document to bytes
//   //   final bytes = await pdf.save();

//   //   // Convert the bytes to a Blob and create a link to download it
//   //   final blob = html.Blob([bytes], 'application/pdf');
//   //   final url = html.Url.createObjectUrlFromBlob(blob);
//   //   final anchor = html.AnchorElement(href: url)
//   //     ..setAttribute('download', 'rapport.pdf')
//   //     ..click();
//   //   html.Url.revokeObjectUrl(url);
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Rapport'),
//         actions: [
//           IconButton(icon: const Icon(Icons.picture_as_pdf), onPressed: () {}
//               // generatePdf,
//               ),
//         ],
//       ),
//       body: Column(children: [
//         Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SizedBox(
//                 width: 300,
//                 child: TextField(
//                   onChanged: (query) {
//                     searchQuery = query;
//                     _filterItems();
//                   },
//                   decoration: InputDecoration(
//                     hintText: 'Rechercher par service...',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     prefixIcon: const Icon(Icons.search),
//                   ),
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: () => _selectDateRange(context),
//                 child: const Text('Sélectionner une plage de dates'),
//               ),
//             ],
//           ),
//         ),
//         filteredItems.isEmpty
//             ? const Center(
//                 child: Text(
//                   'Aucun utilisateur trouvé',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               )
//             : Expanded(
//                 child: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: DataTable(
//                       columns: const [
//                         DataColumn(label: Text('Nom')),
//                         DataColumn(label: Text('Postnom')),
//                         DataColumn(label: Text('Prenom')),
//                         DataColumn(label: Text('Sexe')),
//                         DataColumn(label: Text('Locations')),
//                         DataColumn(label: Text('Date_Heure')),
//                         DataColumn(label: Text('Services')),
//                       ],
//                       rows: List.generate(filteredItems.length, (index) {
//                         final item = filteredItems[index];
//                         return DataRow(
//                           cells: [
//                             DataCell(Text(item['nom'] ?? '')),
//                             DataCell(Text(item['postnom'] ?? '')),
//                             DataCell(Text(item['prenom'] ?? '')),
//                             DataCell(Text(item['sexe'] ?? '')),
//                             DataCell(
//                               Text(
//                                 item['locations'] ?? '',
//                               ),
//                             ),
//                             DataCell(Text(item['created_at'] ?? '')),
//                             DataCell(Text(item['service'] ?? '')),
//                           ],
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ),
//       ]),
//     );
//   }
// }
