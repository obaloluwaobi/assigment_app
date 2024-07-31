import 'package:assigment_app/class/auth/authpage.dart';
import 'package:assigment_app/class/authetication/create%20account/usercreateprofile.dart';
import 'package:assigment_app/class/views/userbottomnav.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserMainPage extends StatefulWidget {
  const UserMainPage({super.key});

  @override
  State<UserMainPage> createState() => _UserMainPageState();
}

class _UserMainPageState extends State<UserMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, data) {
                    if (data.hasData) {
                      if (data.data!.exists) {
                        return const UserBottomNav();
                      } else {
                        return const UserCreateProfile();
                      }
                    } else {
                      return const Wait();
                    }
                  });
            } else {
              return const UserAuthPage();
            }
          }),
    );
  }
}

class Wait extends StatelessWidget {
  const Wait({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: background,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text('Please wait...',
                  style:
                      GoogleFonts.poppins(fontSize: 20, color: Colors.white)),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(child: CircularProgressIndicator()),
          ],
        ));
  }
}
