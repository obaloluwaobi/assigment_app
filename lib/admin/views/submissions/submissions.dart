import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/admin/views/submissions/viewdetails.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AdminStudentSubmission extends StatefulWidget {
  const AdminStudentSubmission({super.key});

  @override
  State<AdminStudentSubmission> createState() => _AdminStudentSubmissionState();
}

class _AdminStudentSubmissionState extends State<AdminStudentSubmission> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'Submissions',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      body: SafeArea(
        child: FadeInUp(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('assignments')
                .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, assignmentSnapsnot) {
              if (assignmentSnapsnot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!assignmentSnapsnot.hasData ||
                  assignmentSnapsnot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No submission made yet',
                    style: size16,
                  ),
                );
              }
              if (assignmentSnapsnot.hasError) {
                return const Center(child: Text('error'));
              }
              return ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  itemCount: assignmentSnapsnot.data!.docs.length,
                  itemBuilder: (context, item) {
                    final data = assignmentSnapsnot.data!.docs[item];
                    var dataId = data.id;
                    print(dataId);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[900],
                                border: Border.all(color: Colors.black)),
                            child: ListTile(
                              title: Text(
                                data['title'],
                                style: size16w,
                              ),
                            ),
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('submission')
                                  .where('assignmentId', isEqualTo: dataId)
                                  .snapshots(),
                              builder: (context, submissionSnapshot) {
                                if (!submissionSnapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ViewDetails(
                                                getData: submissionSnapshot)));
                                  },
                                  child: Container(
                                    height: 60,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: submissionSnapshot
                                            .data!.docs.length,
                                        itemBuilder: (context, submit) {
                                          // final get = submissionSnapshot
                                          //     .data?.docs[submit];
                                          final length = submissionSnapshot
                                              .data?.docs.length;
                                          return Container(
                                            decoration: BoxDecoration(
                                                color: white,
                                                border: Border.all(
                                                  color: Colors.grey.shade700,
                                                ),
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(12),
                                                    bottomRight:
                                                        Radius.circular(12))),
                                            child: ListTile(
                                              title: length == 1
                                                  ? Text('${length} Answer')
                                                  : Text('${length} Answers'),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              })
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}
