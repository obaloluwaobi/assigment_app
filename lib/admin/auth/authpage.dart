import 'package:assigment_app/admin/authetication/create%20account/create_acct.dart';
import 'package:assigment_app/admin/authetication/login/login.dart';
import 'package:assigment_app/class/authetication/create%20account/usercreate_acct.dart';
import 'package:assigment_app/class/authetication/login/userlogin.dart';
import 'package:flutter/material.dart';

class AdminAuthPage extends StatefulWidget {
  const AdminAuthPage({super.key});

  @override
  State<AdminAuthPage> createState() => _AdminAuthPageState();
}

class _AdminAuthPageState extends State<AdminAuthPage> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return AdminLogin(
        showResigter: toggleView,
      );
    } else {
      return AdminCreateAcct(
        showLogin: toggleView,
      );
    }
  }
}
