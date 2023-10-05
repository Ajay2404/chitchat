import 'package:chitchat/common/assets/apis.dart';
import 'package:chitchat/common/theme/app_css.dart';
import 'package:chitchat/extensions/extensions/text_style_extensions.dart';
import 'package:chitchat/helper/dialogs.dart';
import 'package:chitchat/screen/app_screens/homescreen/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return null;
      }
      final GoogleSignInAuthentication? googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print("signInWithGoogle:$e");
      Dialogs.showSnackBar(context, "Check your connection and try again.");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff5c8bff),
        body: Column(children: [
          Image.asset("images/image/welcome.jpeg"),
          InkWell(
            onTap: () {
              //for show progress
              Dialogs.showProgressBar(context);
              signInWithGoogle().then((user) async {
                //for hide progress
                Navigator.pop(context);
                if (user != null) {
                  print(
                      "User: ${user.user?.uid}");
                  print("User: ${user.additionalUserInfo?.profile}");

                  if (await APIs.userExists()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  } else {
                    APIs.createUser().then((value) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    });
                  }
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.only(top: 280),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              width: 300,
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Continue with",
                    style: AppCss.tenorSansblack16.textColor(Colors.white),
                  ),
                  SizedBox(width: 10),
                  Image.asset("images/image/google.png", height: 60),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
