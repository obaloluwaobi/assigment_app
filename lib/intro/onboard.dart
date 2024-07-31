import 'package:assigment_app/admin/auth/mainpage.dart';
import 'package:assigment_app/admin/authetication/login/login.dart';
import 'package:assigment_app/class/auth/mainpage.dart';
import 'package:assigment_app/class/authetication/login/userlogin.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          shrinkWrap: true,
          children: [
            Image.asset(
              'assets/onboard.png',
              width: 300,
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'SUBMIT',
              style: TextStyle(fontSize: 30, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'An online assignment solution for modern days institutions',
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            Btn(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const MainPage()));
              },
              child: Text(
                'Admin',
                style: TextStyle(fontSize: 20, color: white),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Btn(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserMainPage()));
              },
              bgnColor: white,
              side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                  strokeAlign: BorderSide.strokeAlignCenter),
              child: Text(
                'Student',
                style: size20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Btn extends StatelessWidget {
  final Color? bgnColor;
  final void Function()? onTap;
  final Widget? child;
  final BorderSide? side;
  const Btn(
      {super.key,
      required this.child,
      required this.onTap,
      this.bgnColor = Colors.black,
      this.side = BorderSide.none});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: bgnColor,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))),
              side: side),
          onPressed: onTap,
          child: child),
    );
  }
}
