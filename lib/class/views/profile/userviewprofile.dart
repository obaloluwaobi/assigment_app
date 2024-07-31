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
            final pics = snapshot.data?.get('url') ?? 'name';
            final fullname = snapshot.data?.get('fullname') ?? 'name';
            final dept = snapshot.data?.get('dept') ?? 'name';
            final faculty = snapshot.data?.get('faculty') ?? 'name';
            final institution = snapshot.data?.get('institution') ?? 'name';
            final phone = snapshot.data?.get('phone') ?? 'name';
            final matric = snapshot.data?.get('matric') ?? 'name';

            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: NetworkImage(pics))),
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