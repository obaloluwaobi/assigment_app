import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/class/views/home/submit.dart';
import 'package:assigment_app/class/views/home/view_submit.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Assignments',
          style: size20,
        ),
        centerTitle: true,
      ),
      backgroundColor: background2,
      body: FadeInUp(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('assignments')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No avaliable assignment'),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }

              return SafeArea(
                top: true,
                child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      var getData = snapshot.data?.docs[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: primaryColor),
                        ),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SubmitAssignment(
                                          getData: getData,
                                        )));
                          },
                          leading: Icon(
                            Icons.assignment_add,
                            color: white,
                          ),
                          title: Text(
                            getData?['title'],
                            style: size16w,
                          ),
                          subtitle: Text(
                            'due date: ${getData?['due date']}',
                            style: size14w,
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
