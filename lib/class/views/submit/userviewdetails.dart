import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AnswerView extends StatelessWidget {
  const AnswerView({super.key, required this.getData});
  final QueryDocumentSnapshot<Map<String, dynamic>>? getData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'View Answer',
          style: size20,
        ),
      ),
      body: FadeIn(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Text(
              'to: ${getData?['fullname']}',
              style: size16,
            ),
            Divider(),
            Text(
              'at: ${getData?['submittedAt'].toDate().toString()}',
              style: size16,
            ),
            Divider(),
            getData?['score'] == '0'
                ? Text(
                    'Not graded yet',
                    style: size16,
                  )
                : Text(
                    'Score: ${getData?['score']}',
                    style: size16,
                  ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            Text(
              getData?['answer'],
              style: size16,
            ),
          ],
        ),
      ),
    );
  }
}
