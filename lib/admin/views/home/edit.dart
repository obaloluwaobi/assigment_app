import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class EditAssignment extends StatefulWidget {
  const EditAssignment({super.key, required this.getData, required this.id});
  final QueryDocumentSnapshot<Map<String, dynamic>>? getData;
  final String? id;

  @override
  State<EditAssignment> createState() => _EditAssignmentState();
}

class _EditAssignmentState extends State<EditAssignment> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController gradeController = TextEditingController();
  final _user = FirebaseAuth.instance.currentUser!;
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
        await FirebaseFirestore.instance
            .collection('assignments')
            .doc(widget.id)
            .update({
          'title': titleController.text.trim(),
          'descriptions': descriptionController.text.trim(),
          'due date': dateController.text.trim(),
          'grade': gradeController.text.trim(),
          'created': FieldValue.serverTimestamp(),
          'fullname': name.trim(),
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Edit successfully')),
        );
      }
      Navigator.pop(context);
    } on FirebaseException catch (e) {
      print(e.toString());
    }
  }

  bool check = false;
  @override
  void initState() {
    // TODO: implement initState
    titleController.addListener(() {
      update();
    });
    descriptionController.addListener(() {
      update();
    });
    gradeController.addListener(() {
      update();
    });
    dateController.addListener(() {
      update();
    });
    super.initState();
  }

  update() {
    setState(() {
      check = titleController.text.isNotEmpty &&
          descriptionController.text.isNotEmpty &&
          gradeController.text.isNotEmpty &&
          dateController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: const Text('Edit Assignment'),
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
                return const Center(
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
                        //contentPadding: EdgeInsets.symmetric(vertical: 50),
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
                          onPressed: check
                              ? () {
                                  assign(fullname);
                                  Navigator.pop(context);
                                }
                              : null,
                          child: Text(
                            'Update',
                            style: check
                                ? size16w
                                : GoogleFonts.poppins(
                                    color: primaryColor, fontSize: 16),
                          )))
                ],
              );
            }),
      ),
    );
  }
}
