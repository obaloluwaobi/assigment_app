import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/admin/views/profile/aboutproject.dart';
import 'package:assigment_app/admin/views/profile/list_students.dart';
import 'package:assigment_app/admin/views/profile/viewprofile.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:assigment_app/intro/onboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminProfilePage extends StatefulWidget {
  const AdminProfilePage({super.key});

  @override
  State<AdminProfilePage> createState() => _AdminProfilePageState();
}

class _AdminProfilePageState extends State<AdminProfilePage> {
  final _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'Profile',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      body: FadeInUp(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admins')
                .doc(_user.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasData) {
                final fullname = snapshot.data?.get('fullname') ?? 'name';
                final pics = snapshot.data?.get('url') ?? 'name';
                return ListView(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        height: 150,
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(19)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image:
                                    DecorationImage(image: NetworkImage(pics)),
                                color: white,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    fullname,
                                    style: size20boldw,
                                  ),
                                  Text(
                                    _user.email!,
                                    style: size14w,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    ProfileBtn(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewProfile()));
                      },
                      data: 'Profile',
                      leading: Icons.person_2_outlined,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                    ProfileBtn(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListStudents()));
                      },
                      data: 'List of students',
                      leading: Icons.person_2_outlined,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                    ProfileBtn(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutProject()));
                      },
                      data: 'About Project',
                      leading: Icons.person_2_outlined,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                    ProfileBtn(
                      onTap: () {
                        launchEmail();
                      },
                      data: 'Feedback',
                      leading: Icons.person_2_outlined,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                    ProfileBtn(
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnboardPage()));
                      },
                      data: 'Logout',
                      leading: Icons.logout_outlined,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                  ],
                );
              }
              return Center(
                  child: CircularProgressIndicator(
                color: background,
              ));
            }),
      ),
    );
  }
}

class ProfileBtn extends StatelessWidget {
  final void Function()? onTap;
  final String data;
  final IconData? leading;
  final IconData? trailing;
  const ProfileBtn(
      {super.key,
      required this.data,
      required this.leading,
      required this.trailing,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[900], borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListTile(
        onTap: onTap,
        title: Text(
          data,
          style: size16w,
        ),
        leading: Icon(
          leading,
          color: white,
        ),
        trailing: Transform.rotate(
            angle: pi,
            child: Icon(
              trailing,
              color: white,
            )),
      ),
    );
  }
}
