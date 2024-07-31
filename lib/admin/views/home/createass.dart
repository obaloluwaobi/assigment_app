import 'dart:io';
import 'dart:math';

import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateAssignment extends StatefulWidget {
  const CreateAssignment({super.key});

  @override
  State<CreateAssignment> createState() => _CreateAssignmentState();
}

class _CreateAssignmentState extends State<CreateAssignment> {
  // String duedate = '';
  final _user = FirebaseAuth.instance.currentUser!;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  Future assign(String name) async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      if (titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          dateController.text.isNotEmpty &&
          gradeController.text.isNotEmpty) {
        await FirebaseFirestore.instance.collection('assignments').add({
          'title': titleController.text.trim(),
          'descriptions': descriptionController.text.trim(),
          'due date': dateController.text.trim(),
          'grade': gradeController.text.trim(),
          'id': _user.uid.toString(),
          'created': FieldValue.serverTimestamp(),
          'fullname': name.trim(),
        });
      }
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    gradeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: Text('Create Assignment'),
        centerTitle: true,
      ),
      backgroundColor: background2,
      body: SafeArea(
        top: true,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('admins')
                .doc(_user.uid)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final fullname = snapshot.data?.get('fullname') ?? 'name';
              return ListView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  Text(
                    'Assignment title',
                    style: size16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Description',
                    style: size16,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    maxLines: null,
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 50),
                        hintText: '',
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10)))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Due date',
                              style: size16,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                readOnly: true,
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      firstDate: DateTime(2000),
                                      lastDate: DateTime(2101),
                                      initialDate: DateTime.now());
                                  if (pickedDate != null) {
                                    print(pickedDate);
                                    String formattedDate =
                                        DateFormat('dd-MM-yyyy')
                                            .format(pickedDate);
                                    setState(() {
                                      dateController.text = formattedDate;
                                    });
                                  }
                                },
                                controller: dateController,
                                decoration: const InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Grade point',
                              style: size16,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 200,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                controller: gradeController,
                                decoration: const InputDecoration(
                                    hintText: '',
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)))),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Container(
                  //   //    margin: EdgeInsets.symmetric(vertical: 10),
                  //   decoration: BoxDecoration(
                  //       border: Border.all(color: dark),
                  //       borderRadius: BorderRadius.circular(12)),
                  //   child: ListTile(
                  //     onTap: () {},
                  //     leading: const Icon(Icons.attach_file_outlined),
                  //     title: Text(
                  //       'Add an attachment',
                  //       style: size16,
                  //     ),
                  //   ),
                  // ),
                  //file

                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            assign(fullname);
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Assign',
                            style: size16w,
                          )))
                ],
              );
            }),
      ),
    );
  }
}
