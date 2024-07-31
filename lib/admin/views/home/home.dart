import 'package:animate_do/animate_do.dart';
import 'package:assigment_app/admin/views/home/createass.dart';
import 'package:assigment_app/admin/views/home/viewass.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  final _user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        tooltip: 'Create assignment',
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateAssignment()));
        },
        child: Icon(
          color: white,
          Icons.add,
          size: 30,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: background,
        title: Text(
          'Summit',
          style: size20,
        ),
      ),
      backgroundColor: background2,
      body: FadeInUp(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('assignments')
                .where('id', isEqualTo: _user.uid.toString())
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Create Assignment',
                        style: size16,
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                );
              }
              if (snapshot.hasError) {
                return const Center(child: Text('error'));
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var getData = snapshot.data?.docs[index];
                  var id = getData?.id;
                  return Dismissible(
                    direction: DismissDirection.horizontal,
                    key: UniqueKey(),
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      color: const Color.fromARGB(255, 238, 140, 173),
                      alignment: Alignment.centerRight,
                      child: const Icon(Icons.delete_forever_outlined,
                          color: Colors.white),
                    ),
                    onDismissed: (direction) {
                      setState(() {
                        FirebaseFirestore.instance
                            .collection('assignments')
                            .doc(id)
                            .delete();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Deleted')),
                        );
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: primaryColor),
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ViewAssignment(
                                        getData: getData,
                                      )));
                        },
                        // leading: const Icon(Icons.assignment_add),
                        title: Text(
                          getData?['title'],
                          style: size16w,
                        ),
                        subtitle: Text(
                          'due date: ${getData?['due date']}',
                          style: size14w,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Container(
                                      height: 100,
                                      child: Column(
                                        children: [],
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: const Icon(Icons.more_vert_outlined),
                          color: white,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
