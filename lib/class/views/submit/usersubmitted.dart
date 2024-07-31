import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/class/views/submit/userviewdetails.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class UserSubmitted extends StatelessWidget {
  const UserSubmitted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'Submitted',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      body: FadeInUp(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('submission')
                .where('studentId',
                    isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
                  child: Text('No submission made yet'),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }
              return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  itemCount: snapshot.data?.docs.length,
                  itemBuilder: (context, index) {
                    final getData = snapshot.data?.docs[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AnswerView(getData: getData)));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 0),
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 0),
                              decoration: BoxDecoration(
                                color: Colors.grey[900],
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: primaryColor),
                              ),
                              child: ListTile(
                                  title: Text(
                                    'to ${getData?['fullname']}',
                                    style: size16w,
                                  ),
                                  subtitle: Text(
                                    maxLines: 1,
                                    style: size16w,
                                    'at: ${getData?['submittedAt'].toDate().toString()}',

                                    ///maxLines: 0,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: dark),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  getData?['score'] == '0'
                                      ? Text(
                                          'Not graded yet',
                                          style: size16,
                                        )
                                      : Text(
                                          'Score: ${getData?['score']}',
                                          style: size16,
                                        ),
                                  getData?['score'] == '0'
                                      ? Icon(
                                          Icons.cancel,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.done_outline_outlined,
                                          color: Colors.green,
                                        )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            }),
      ),
    );
  }
}
