import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ListTeacher extends StatelessWidget {
  const ListTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Teachers', style: size20),
        centerTitle: true,
        backgroundColor: background,
      ),
      backgroundColor: background2,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('admins').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data?.docs[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(
                          data?['fullname'],
                          style: size20w,
                        ),
                        subtitle: Text(
                          '${data?['course']}',
                          style: size16w,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
