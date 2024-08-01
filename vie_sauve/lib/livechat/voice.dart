// import 'package:flutter/material.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';


// class Voicecall extends StatefulWidget {
//   const Voicecall({super.key});

//   @override
//   State<Voicecall> createState() => _VoicecallState();
// }

// class _VoicecallState extends State<Voicecall> {
//   @override
//   void initState() {
//     super.initState();
//     requestPermissions();
//   }

//   Future<void> requestPermissions() async {
//     await Permission.microphone.request();
//     await Permission.camera.request();
//   }

//   void startVoiceCall() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => ZegoUIKitPrebuiltCall(
//           appID: YOUR_APP_ID, // Fill in your App ID
//           appSign: YOUR_APP_SIGN, // Fill in your App Sign
//           userID: YOUR_USER_ID, // Fill in your User ID
//           userName: YOUR_USER_NAME, // Fill in your User Name
//           callID: YOUR_CALL_ID, // Fill in the Call ID
//           config: ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall(),
//         ),
//       ),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//     );
//   }
// }