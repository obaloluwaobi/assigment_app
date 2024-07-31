import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/admin/views/submissions/fulldetails.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatelessWidget {
  const ViewDetails({super.key, required this.getData});
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>? getData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background2,
      appBar: AppBar(
        backgroundColor: background,
        centerTitle: true,
        title: Text(
          'View Submissions',
          style: size20,
        ),
      ),
      body: SafeArea(
        child: FadeInUp(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            itemCount: getData?.data?.docs.length,
            itemBuilder: (context, index) {
              var info = getData?.data?.docs[index];
              var dataId = info?.id;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                FullDetails(get: info, id: dataId)));
                  },
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: dark),
                            color: Colors.grey[900]),
                        child: ListTile(
                          title: Text(
                            '${info?['fullname']}',
                            style: size16w,
                          ),
                          subtitle: Text(
                            'at: ${info?['submittedAt'].toDate().toString()}',
                            style: size16w,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: dark),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            info?['score'] == '0'
                                ? Expanded(
                                    child: Text(
                                      'You have not grade this assessment',
                                      style: size16,
                                    ),
                                  )
                                : Expanded(
                                    child: Text(
                                      'Score: ${info?['score']}',
                                      style: size16,
                                    ),
                                  ),
                            info?['score'] == '0'
                                ? const Icon(
                                    Icons.cancel,
                                    color: Colors.red,
                                  )
                                : const Icon(
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
            },
          ),
        ),
      ),
    );
  }
}
