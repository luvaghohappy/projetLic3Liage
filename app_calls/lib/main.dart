import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const platform = MethodChannel('com.example.app_calls/callState');
  String callStateMessage = 'Aucun appel entrant';

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler((call) async {
      setState(() {
        switch (call.method) {
          case 'incomingCall':
            callStateMessage = 'Incoming call';
            break;
          case 'callAnswered':
            callStateMessage = 'Call answered';
            break;
          case 'callEnded':
            callStateMessage = 'Call ended';
            break;
          case 'missedCall':
            callStateMessage = 'Missed call';
            break;
          default:
            callStateMessage = 'Aucun appel entrant';
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(callStateMessage),
        ),
      ),
    );
  }
}
