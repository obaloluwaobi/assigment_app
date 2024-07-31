import 'package:assigment_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminforgetPassword extends StatefulWidget {
  const AdminforgetPassword({super.key});

  @override
  State<AdminforgetPassword> createState() => _AdminforgetPasswordState();
}

class _AdminforgetPasswordState extends State<AdminforgetPassword> {
  TextEditingController emailController = TextEditingController();
  Future reset() async {
    try {
      if (emailController.text.isNotEmpty) {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      print(e.toString());
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: background,
      ),
      body: Form(
        key: formKey,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                'Enter your email',
                style: size20bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Reset password link will be sent to your email address',
                style: size14,
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                  controller: emailController,
                  //type
                  keyboardType: TextInputType.emailAddress,
                  // validator,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email address';
                    }
                    return null;
                  }, //styling from constant file
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: 'email address',
                    suffixIcon: const Icon(Icons.email_outlined),
                  )),
              const SizedBox(
                height: 100,
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: dark,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      //  if the formfields is not empty then open homepage
                      if (formKey.currentState!.validate()) {
                        reset();
                      }
                    },
                    child: Text(
                      'Reset Password',
                      style: signin,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
