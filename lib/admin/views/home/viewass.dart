import 'package:assigment_app/admin/views/home/edit.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAssignment extends StatelessWidget {
  const ViewAssignment({super.key, required this.getData, required this.id});
  final QueryDocumentSnapshot<Map<String, dynamic>>? getData;
  final String? id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: background2,
      appBar: AppBar(
        title: Text(
          'Assignment Details',
          style: size20,
        ),
        centerTitle: true,
        backgroundColor: background,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.edit_note))
        ],
      ),
      body: Column(
        children: [
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
                Divider(),
                Text(
                  'Due date',
                  style: size16,
                ),
                Text(
                  getData?['due date'],
                  style: size16,
                ),
                Divider(),
                Text(
                  'Grade point',
                  style: size16,
                ),
                Text(
                  getData?['grade'],
                  style: size16,
                ),
                Divider(),
                Text(
                  'Submission type',
                  style: size16,
                ),
                Text(
                  'Text Entry',
                  style: size16,
                ),
                Divider(),
                Text(
                  'Descriptions',
                  style: size16,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  getData?['descriptions'],
                  style: size16,
                ),
                //atachmentifselected
                SizedBox(
                  height: 70,
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
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditAssignment(
                                        getData: getData, id: id)));
                          },
                          child: Text(
                            'Edit',
                            style: size16w,
                          )),
                    )
                  ])))
        ],
      ),
    );
  }
}
