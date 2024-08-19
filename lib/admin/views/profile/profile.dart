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
                Map<String, dynamic> userData =
                    snapshot.data!.data() as Map<String, dynamic>;
                final fullname = userData['fullname'] ?? 'name';
                String? pics = userData['url'] as String?;
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
                                color: white,
                                image: pics != null
                                    ? DecorationImage(
                                        image: NetworkImage(pics),
                                        fit: BoxFit.cover)
                                    : null,
                              ),
                              child: pics == null
                                  ? Icon(
                                      Icons.person,
                                      size: 100,
                                      color: Colors.grey[300],
                                    )
                                  : null,
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
                      leading: Icons.list,
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
                      leading: Icons.info,
                      trailing: Icons.arrow_back_ios_new_outlined,
                    ),
                    ProfileBtn(
                      onTap: () {
                        launchEmail();
                      },
                      data: 'Feedback',
                      leading: Icons.feedback,
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
                    ProfileBtn(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete your Account?'),
                              content: const Text(
                                  '''If you select Delete we will delete your account on our server'''),
                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                TextButton(
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                  onPressed: () {
                                    deleteUserAccount();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      data: 'Delete account',
                      leading: Icons.delete,
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

  Future<void> deleteUserAccount() async {
    try {
      await FirebaseAuth.instance.currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      print(e);

      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      print(e);

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData =
          FirebaseAuth.instance.currentUser?.providerData.first;

      if (AppleAuthProvider().providerId == providerData!.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await FirebaseAuth.instance.currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await FirebaseAuth.instance.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
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
