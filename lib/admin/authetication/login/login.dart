import 'package:assigment_app/admin/authetication/forgetpassword/password.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AdminLogin extends StatefulWidget {
  final VoidCallback showResigter;
  const AdminLogin({super.key, required this.showResigter});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final formKey = GlobalKey<FormState>();
  bool visible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future signIn() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                  height: 100,
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                        size: 50, color: Colors.black),
                  )),
            );
          });
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        UserCredential result = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());
        User? user = result.user;
        if (user != null) {
          // Check if user exists in 'admins' collection
          DocumentSnapshot userData = await FirebaseFirestore.instance
              .collection('admins')
              .doc(user.uid)
              .get();

          if (userData.exists) {
            return "Success";
          } else {
            await FirebaseAuth.instance.signOut();

            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return const Text(
            //           'This is not an admin account. Please use the correct login');
            //     });

            // return "This is not a student account. Please use the correct login.";
          }
        }
      }
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('invalid-email',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-disabled") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-disabled',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "user-not-found") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('user-not-found',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-credential") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('wrong-password',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: background,
        ),
        backgroundColor: background,
        body: Form(
          key: formKey,
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                //logo

                Text(
                  'Welcome Lecturer',
                  style: size30bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Sign in to continue',
                  style: size16,
                ),
                const SizedBox(
                  height: 50,
                ), //formfield
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
                  height: 40,
                ),

                TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: !visible,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter your password';
                    } else if (value.length < 8) {
                      return 'Password must be longer than 8 characters';
                    }
                    return null;
                  },
                  style: size16bold,
                  decoration: InputDecoration(
                    hintStyle: size16,
                    border: const UnderlineInputBorder(),
                    hintText: ' password',
                    //to make the password becaome visible or not
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            visible = !visible;
                          });
                        },
                        icon: visible
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined)),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //forget password text btn
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AdminforgetPassword()));
                  },
                  child: Text(
                    'Forget password?',
                    textAlign: TextAlign.right,
                    style: size14bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                          signIn();
                        }
                      },
                      child: Text(
                        'Log in',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account? ',
                      style: size14,
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.showResigter();
                      },
                      child: Text(
                        'Sign up',
                        style: size16bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
