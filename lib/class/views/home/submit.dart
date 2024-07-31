import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Submit extends StatefulWidget {
  final String assignmentId;
  const Submit({super.key, required this.assignmentId});

  @override
  State<Submit> createState() => _SubmitState();
}

class _SubmitState extends State<Submit> {
  TextEditingController _answerController = TextEditingController();
  Future submit(String name, String matric) async {
    try {
      if (_answerController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('submission').add({
          'assignmentId': widget.assignmentId,
          'studentId': FirebaseAuth.instance.currentUser!.uid,
          'submittedAt': FieldValue.serverTimestamp(),
          'answer': _answerController.text,
          'fullname': name.trim(),
          'matric no': matric.trim(),
          'score': '0',
        });
      }
    } on FirebaseException catch (e) {
      print(e.toString);
    }
  }

  final _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: background,
        title: Text(
          'Submit Answer',
          style: size20,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_user.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            final fullname = snapshot.data?.get('fullname') ?? 'name';
            final matric = snapshot.data?.get('matric') ?? 'name';
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    children: [
                      TextFormField(
                        maxLines: null,
                        minLines: null,
                        controller: _answerController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: 'Type here...'),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: 50,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: primaryColor),
                              onPressed: () {
                                submit(fullname, matric);
                                Navigator.pop(context);
                              },
                              child: Text(
                                'submit',
                                style: size16w,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
