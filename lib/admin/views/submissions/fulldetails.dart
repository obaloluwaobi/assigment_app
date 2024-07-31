import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FullDetails extends StatefulWidget {
  const FullDetails({super.key, required this.get, required this.id});
  final QueryDocumentSnapshot<Map<String, dynamic>>? get;
  final String? id;

  @override
  State<FullDetails> createState() => _FullDetailsState();
}

class _FullDetailsState extends State<FullDetails> {
  final TextEditingController gradeController = TextEditingController();
  Future update() async {
    try {
      await FirebaseFirestore.instance
          .collection('submission')
          .doc(widget.id)
          .update({'score': gradeController.text.trim()});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Grade submitted successfully')),
      );

      // Check if we found any matching documents
    } on FirebaseException catch (e) {
      print('Error updating document: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'Answer',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Create assignment',
        shape: const CircleBorder(),
        onPressed: () {
          showDialog(
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    textAlign: TextAlign.center,
                    'Grade',
                    style: size16,
                  ),
                  content: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: gradeController,
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            update();
                          });

                          Navigator.pop(context);
                        },
                        child: Text(
                          'grade',
                          style: size16,
                        ))
                  ],
                );
              },
              context: context);
        },
        child: Icon(
          Icons.done_all_rounded,
          color: white,
        ),
      ),
      body: FadeIn(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          children: [
            Text(
              widget.get?['fullname'],
              style: size16,
            ),
            Divider(),
            // Text(
            //   get?['matric'],
            //   style: size16,
            // ),
            // const SizedBox(
            //   height: 10,
            // ),
            widget.get?['score'] == '0'
                ? Text(
                    'You have not grade this assessment',
                    style: size16,
                  )
                : Text(
                    'Score: ${widget.get?['score']}',
                    style: size16,
                  ),
            Divider(),
            Text(
              '${widget.get?['submittedAt'].toDate().toString()}',
              style: size16,
            ),
            const SizedBox(
              height: 10,
            ),
            Divider(),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.get?['answer'],
              style: size16,
            ),
          ],
        ),
      ),
    );
  }
}
