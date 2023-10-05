// import 'package:chitchat/screen/app_screens/dashboardscreen/homeScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class VerificationScreen extends StatefulWidget {
//   final String number;
//   final String verId;
//
//   const VerificationScreen(this.number, this.verId, {super.key});
//
//   @override
//   State<VerificationScreen> createState() => _VerificationScreenState();
// }
//
// class _VerificationScreenState extends State<VerificationScreen> {
//   TextEditingController otp = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Color(0xfff5c8bff),
//           title: Text("Verifying your number"),
//         ),
//         body: Column(children: [
//           Container(
//             margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//             width: 410,
//             child: Text(
//               "You've tried to register +91 ${widget.number} recently. Wait before requesting an SMS with your code?",
//               style: TextStyle(fontSize: 18), // Fix the style here
//             ),
//           ),
//           Container(
//             width: 140,
//             child: TextField(
//               controller: otp,
//               autofocus: true,
//               keyboardType: TextInputType.number,
//               textAlign: TextAlign.center,
//               maxLength: 6,
//               style: TextStyle(
//                 fontSize: 30,
//               ),
//               decoration: InputDecoration(
//                 hintText: "-  -  -  -  -  -",
//                 hintStyle: TextStyle(fontSize: 30),
//               ),
//             ),
//           ),
//           Text("Enter 6-digit code"),
//           TextButton(
//             onPressed: () {},
//             child: Text("Didn't receive code?"),
//           ),
//         ]),
//         bottomNavigationBar: InkWell(
//           onTap: () async {
//             FirebaseAuth auth = FirebaseAuth.instance;
//             String smsCode = "${otp.text}";
//             PhoneAuthCredential credential = PhoneAuthProvider.credential(
//               verificationId: widget.verId,
//               smsCode: smsCode,
//             );
//             await auth.signInWithCredential(credential);
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) {
//                   return DashBoardScreen();
//                 },
//               ),
//             );
//           },
//           child: Container(
//             margin: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
//             decoration: BoxDecoration(
//               color: Colors.black,
//               borderRadius: BorderRadius.all(Radius.circular(20)),
//             ),
//             alignment: Alignment.center,
//             height: 50,
//             width: 100,
//             child: Text(
//               "Submit",
//               style: TextStyle(color: Colors.white),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
