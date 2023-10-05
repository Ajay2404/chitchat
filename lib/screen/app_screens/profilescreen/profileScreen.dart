import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chitchat/common/assets/apis.dart';
import 'package:chitchat/common/theme/app_css.dart';
import 'package:chitchat/helper/dialogs.dart';
import 'package:chitchat/models/chatUsers.dart';
import 'package:chitchat/screen/auth_screens/loginscreen/loginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  final ChatUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final formKey = GlobalKey<FormState>();
  String? pickImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.red,
          onPressed: () async {
            Dialogs.showProgressBar(context);
            await FirebaseAuth.instance.signOut().then((value) async {
              await GoogleSignIn().signOut().then((value) {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ));
              });
            });
          },
          label: const Text("Log Out"),
          icon: const Icon(Icons.logout),
        ).paddingOnly(bottom: Insets.i10),
        appBar: AppBar(backgroundColor: const Color(0xff5c8bff)),
        body: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                Stack(
                  children: [
                    pickImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              File(pickImage!),
                              height: 200,
                              width: 200,
                              fit: BoxFit.cover,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CachedNetworkImage(
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                              imageUrl: widget.user.image,
                              // placeholder: (context, url) =>
                              //     CircleAvatar(child: Icon(CupertinoIcons.person)),
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(
                                      child: Icon(CupertinoIcons.person)),
                            ),
                          ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: MaterialButton(
                        elevation: 1,
                        onPressed: () => _showBottomSheet(),
                        color: Colors.white,
                        shape: const CircleBorder(),
                        child: const Icon(Icons.edit),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  widget.user.email,
                  style: const TextStyle(color: Colors.black54, fontSize: 16),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  onSaved: (val) => APIs.me.name = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: widget.user.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "eg. Nikhil Tyler",
                      label: const Text("Name")),
                ).paddingSymmetric(horizontal: 20),
                const SizedBox(height: 20),
                TextFormField(
                  onSaved: (val) => APIs.me.about = val ?? '',
                  validator: (val) =>
                      val != null && val.isNotEmpty ? null : 'Required Field',
                  initialValue: widget.user.about,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      prefixIcon: const Icon(Icons.info),
                      hintText: "eg. Feeling Happy",
                      label: const Text("About")),
                ).paddingSymmetric(horizontal: 20),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        minimumSize: const Size(120, 60)),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        APIs.updateUserInfo().then((value) {
                          Dialogs.showSnackBar(
                              context, "Profile Updated Successfully");
                        });
                      }
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      "Update",
                      style: TextStyle(fontSize: 16),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20))),
      context: context,
      builder: (context) {
        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(top: 20, bottom: 30),
          children: [
            const Text(
              textAlign: TextAlign.center,
              "Pick Profile Picture",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        fixedSize: const Size(80, 80)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 80);
                      setState(() {
                        pickImage = image!.path;
                      });
                      APIs.updateProfilePicture(File(pickImage!));
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.image,
                      color: Colors.black,
                      size: 30,
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        backgroundColor: Colors.white,
                        fixedSize: const Size(80, 80)),
                    onPressed: () async {
                      final ImagePicker picker = ImagePicker();
                      final XFile? photo = await picker.pickImage(
                          source: ImageSource.camera, imageQuality: 80);
                      setState(() {
                        pickImage = photo!.path;
                      });
                      APIs.updateProfilePicture(File(pickImage!));
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.black,
                      size: 30,
                    ))
              ],
            ),
          ],
        );
      },
    );
  }
}
