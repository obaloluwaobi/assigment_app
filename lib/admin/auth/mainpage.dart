import 'package:assigment_app/admin/auth/authpage.dart';
import 'package:assigment_app/admin/authetication/create%20account/create_acct.dart';
import 'package:assigment_app/admin/authetication/create%20account/createprofile.dart';
import 'package:assigment_app/admin/views/bottomnav.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('admins')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: (context, data) {
                    if (data.hasData) {
                      if (data.data!.exists) {
                        return const AdminbottomNav();
                      } else {
                        return const AdminCreateProfile();
                      }
                    } else {
                      return const Wait();
                    }
                  });
            } else {
              return const AdminAuthPage();
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
