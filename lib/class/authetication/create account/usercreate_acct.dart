import 'package:assigment_app/class/authetication/create%20account/usercreateprofile.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class UsercreateAcct extends StatefulWidget {
  final VoidCallback showLogin;
  const UsercreateAcct({super.key, required this.showLogin});

  @override
  State<UsercreateAcct> createState() => _UsercreateAcctState();
}

class _UsercreateAcctState extends State<UsercreateAcct> {
  final formKey = GlobalKey<FormState>();

  bool visible = false;
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future createAccount() async {
    try {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Container(
                  height: 100,
                  child: Center(
                    child: LoadingAnimationWidget.hexagonDots(
                      size: 50,
                      color: Colors.black,
                    ),
                  )),
            );
          });
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty &&
          confirmpasswordController.text.isNotEmpty) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());
      }
      // showDialog(
      //     context: context,
      //     builder: (context) {
      //       return const AlertDialog(
      //         content: CircularProgressIndicator(),
      //       );
      //     });
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      if (e.code == "email-already-in-use") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(
                    'The email already exists try logging in with this email.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "invalid-email") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('This email address does not exist.',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "operation-not-allowed") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('this operation is not allowed',
                    style: GoogleFonts.dmSans(fontSize: 16)),
              );
            });
        print(e.message);
      }
      if (e.code == "weak-password") {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('Weak Password!',
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
    confirmpasswordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'Hi! Student',
                style: size30bold,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Create a new account',
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
                    hintText: 'Email address',
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
                  hintText: 'Create Password',
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
                height: 40,
              ),

              TextFormField(
                controller: confirmpasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: !visible,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'confirm your password';
                  } else if (value.length < 8) {
                    return 'Password must be longer than 8 characters';
                  } else if (passwordController.text !=
                      confirmpasswordController.text) {
                    return 'password does not match';
                  }
                  return null;
                },
                style: size16bold,
                decoration: InputDecoration(
                  hintStyle: size16,
                  border: const UnderlineInputBorder(),
                  hintText: 'Confirm Password',
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
                        createAccount();
                      }
                    },
                    child: Text(
                      'Register',
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
                    'Already have an account? ',
                    style: size14,
                  ),
                  GestureDetector(
                    onTap: () {
                      widget.showLogin();
                    },
                    child: Text(
                      'Sign in',
                      style: size16bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
