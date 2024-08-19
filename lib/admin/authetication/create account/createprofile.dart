import 'dart:io';

import 'package:assigment_app/admin/views/bottomnav.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class AdminCreateProfile extends StatefulWidget {
  const AdminCreateProfile({super.key});

  @override
  State<AdminCreateProfile> createState() => _AdminCreateProfileState();
}

class _AdminCreateProfileState extends State<AdminCreateProfile> {
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  TextEditingController fullnameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController deptController = TextEditingController();
  TextEditingController facultyController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  File? photo;

  final ImagePicker picker = ImagePicker();
  Future imgPick() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        photo = File(pickedFile.path);
      } else {
        print('No image selected');
      }
    });
  }

  Future createProfile() async {
    try {
      if (fullnameController.text.isNotEmpty &&
          courseController.text.isNotEmpty &&
          deptController.text.isNotEmpty &&
          facultyController.text.isNotEmpty &&
          institutionController.text.isNotEmpty) {
        final User? _user = FirebaseAuth.instance.currentUser;
        final String _uid = _user!.uid;
        String? downloadURL;
        if (photo != null) {
          final fileName = basename(photo!.path);
          final destination = 'files/$fileName';

          UploadTask uploadTask = FirebaseStorage.instance
              .ref(destination)
              .child('profile$_uid/')
              .putFile(photo!);

          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          String downloadURL = await taskSnapshot.ref.getDownloadURL();

          print(downloadURL);
        }
        await FirebaseFirestore.instance
            .collection('admins')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          'fullname': fullnameController.text.trim(),
          'course': courseController.text.trim(),
          'dept': deptController.text.trim(),
          'faculty': facultyController.text.trim(),
          'institution': institutionController.text.trim(),
          if (downloadURL != null) 'url': downloadURL.toString()
        });
      }
    } on FirebaseException catch (e) {
      print('empty field');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        title: const Text(
          'Create Admin Profile',
        ),
        leading: IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
            },
            icon: Icon(Icons.arrow_back_ios)),
        centerTitle: true,
      ),
      backgroundColor: background,
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  imgPick();
                },
                child: photo != null
                    ? Container(
                        margin: const EdgeInsets.symmetric(horizontal: 30),
                        height: 200,
                        decoration: BoxDecoration(
                            border: Border.all(width: 2),
                            color: Colors.black,
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: FileImage(photo!),
                                fit: BoxFit.fitWidth)),
                      )
                    : Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: const BoxDecoration(
                                color: Colors.grey, shape: BoxShape.circle),
                            child: const Icon(
                              Icons.person,
                              size: 130,
                            ),
                          ),
                          const Positioned(
                            top: 90,
                            left: 130,
                            right: 0,
                            bottom: 10,
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
              //formfield
              TextFormField(
                  controller: fullnameController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your full name';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'Full Name',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 30,
              ),

              TextFormField(
                  controller: courseController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the course you teach';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'Course',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  controller: deptController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Department';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'Department',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  controller: facultyController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Faculty';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'Faculty',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  controller: institutionController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Institution';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'Institution',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 30,
              ),

              //login btn
              SizedBox(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: dark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      //if the formfields is not empty then open homepage
                      if (formKey.currentState!.validate()) {
                        createProfile();
                      }
                    },
                    child: Text(
                      'Create Profile',
                      style: signin,
                    )),
              ),
              const SizedBox(
                height: 30,
              ),

              const SizedBox(
                height: 60,
              ),
              //if the user is
            ],
          ),
        ),
      ),
    );
  }
}
