// import 'package:chitchat/screen/auth_screens/authenticationscreen/VerificationScreen/verificationScreen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class AuthenticationScreen extends StatefulWidget {
//   const AuthenticationScreen({super.key});
//
//   @override
//   State<AuthenticationScreen> createState() => _AuthenticationScreenState();
// }
//
// class _AuthenticationScreenState extends State<AuthenticationScreen> {
//   TextEditingController number = TextEditingController();
//   String verId = "";
//
//   @override
//   void dispose() {
//     number.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text("Enter your phone number"),
//           Text("ChitChat will need to verify your account."),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Container(
//                 alignment: Alignment.center,
//                 width: 40,
//                 child: TextField(
//                   readOnly: true,
//                   decoration: InputDecoration(
//                     hintText: "+ 91",
//                     hintStyle: TextStyle(color: Colors.black),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 20),
//               Container(
//                 width: 150,
//                 child: TextField(
//                   controller: number,
//                   autofocus: true,
//                   decoration: InputDecoration(hintText: "phone number"),
//                   keyboardType: TextInputType.phone,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       bottomNavigationBar: InkWell(
//         onTap: () {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return Container(
//                 alignment: Alignment.center,
//                 child: SimpleDialog(
//                   title: Text("You entered the phone number:"),
//                   children: [
//                     Text(
//                       "+91 ${number.text}",
//                       style: TextStyle(fontSize: 20),
//                     ).paddingOnly(left: 20),
//                     SizedBox(height: 10),
//                     Text(
//                       """Is this OK, or would you like to edit
// the number?""",
//                       style: TextStyle(fontSize: 18),
//                     ).paddingOnly(left: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                           child: Text("Edit"),
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             await FirebaseAuth.instance.verifyPhoneNumber(
//                               phoneNumber: '+91 ${number.text}',
//                               verificationCompleted:
//                                   (PhoneAuthCredential credential) {},
//                               verificationFailed: (FirebaseAuthException e) {},
//                               codeSent:
//                                   (String verificationId, int? resendToken) {
//                                 setState(() {
//                                   verId = verificationId;
//                                 });
//                               },
//                               codeAutoRetrievalTimeout:
//                                   (String verificationId) {},
//                             );
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) {
//                                   return VerificationScreen(number.text, verId);
//                                 },
//                               ),
//                             );
//                           },
//                           child: Text("OK"),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 100, vertical: 50),
//           decoration: BoxDecoration(
//             color: Colors.black,
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//           ),
//           alignment: Alignment.center,
//           height: 50,
//           width: 100,
//           child: Text(
//             "Next",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//     );
//   }
// }
