import 'package:assigment_app/class/views/home/submit.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SubmitAssignment extends StatelessWidget {
  const SubmitAssignment({
    super.key,
    required this.getData,
  });

  final QueryDocumentSnapshot<Map<String, dynamic>>? getData;
  @override
  Widget build(BuildContext context) {
    var assignid = getData!.id;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'View Assignment',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      body: Column(children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            children: [
              Text(
                'Title',
                style: size16,
              ),
              Text(
                getData?['title'],
                style: size16,
              ),
              const Divider(),
              Text(
                'Due date',
                style: size16,
              ),
              Text(
                getData?['due date'],
                style: size16,
              ),
              const Divider(),
              Text(
                'Grade point',
                style: size16,
              ),
              Text(
                getData?['grade'],
                style: size16,
              ),
              const Divider(),
              Text(
                'Submission type',
                style: size16,
              ),
              Text(
                'Text Entry',
                style: size16,
              ),

              const Divider(),
              Text(
                'Created by',
                style: size16,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                getData?['fullname'],
                style: size16,
              ),
              const Divider(),
              Text(
                'Created at',
                style: size16,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                '${getData?['created'].toDate().toString()}',
                style: size16,
              ),
              const Divider(),
              Text(
                'Descriptions',
                style: size16,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                getData?['descriptions'],
                style: size16,
              ),
              //atachmentifselected
              const SizedBox(
                height: 70,
              )
            ],
          ),
        ),
        Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 50,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: const RoundedRectangleBorder()),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Submit(
                                  assignmentId: assignid,
                                )));
                  },
                  child: Text(
                    'Submit',
                    style: size16w,
                  )),
            )),
          ],
        )
      ]),
    );
  }
}
