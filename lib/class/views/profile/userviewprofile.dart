import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserViewProfile extends StatelessWidget {
  const UserViewProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        title: Text(
          'View Profile',
          style: size20,
        ),
        centerTitle: true,
        backgroundColor: background,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots(),
          builder: (context, snapshot) {
            Map<String, dynamic> userData =
                snapshot.data!.data() as Map<String, dynamic>;
            final fullname = userData['fullname'] ?? 'name';
            String? pics = userData['url'] as String?;

            final dept = userData['dept'] ?? 'name';
            final faculty = userData['faculty'] ?? 'name';
            final institution = userData['institution'] ?? 'name';
            final phone = userData['phone'] ?? 'name';
            final matric = userData['matric'] ?? 'name';

            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: pics != null
                          ? DecorationImage(
                              image: NetworkImage(pics), fit: BoxFit.cover)
                          : null,
                    ),
                    child: pics == null
                        ? Icon(
                            Icons.person,
                            size: 100,
                            color: Colors.grey[900],
                          )
                        : null,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Full Name',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    fullname,
                    style: size16,
                  ),
                  const Divider(),
                  Text(
                    'Phone no.',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    phone,
                    style: size16,
                  ),
                  const Divider(),
                  Text(
                    'matric',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    matric,
                    style: size16,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'department',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    dept,
                    style: size16,
                  ),
                  const Divider(),
                  Text(
                    'faculty',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    faculty,
                    style: size16,
                  ),
                  const Divider(),
                  Text(
                    'Institution',
                    style: size14,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    institution,
                    style: size16,
                  ),
                  const Divider(),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
