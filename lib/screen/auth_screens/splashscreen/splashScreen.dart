import 'dart:async';

import 'package:chitchat/common/config.dart';
import 'package:chitchat/main.dart';
import 'package:chitchat/screen/app_screens/homescreen/homeScreen.dart';
import 'package:chitchat/screen/auth_screens/loginscreen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Color(0xff5c8bff)));

    Timer(
      const Duration(seconds: 3),
      () {
        // Check if the user is already logged in
        if (FirebaseAuth.instance.currentUser != null) {
          // Navigate to homeScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        } else {
          // Navigate to loginScreen
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff5c8bff),
      body: Center(child: Image.asset(imageAssets.splashScreen)),
    );
  }
}
