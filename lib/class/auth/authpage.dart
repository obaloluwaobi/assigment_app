import 'package:assigment_app/class/authetication/create%20account/usercreate_acct.dart';
import 'package:assigment_app/class/authetication/login/userlogin.dart';
import 'package:flutter/material.dart';

class UserAuthPage extends StatefulWidget {
  const UserAuthPage({super.key});

  @override
  State<UserAuthPage> createState() => _UserAuthPageState();
}

class _UserAuthPageState extends State<UserAuthPage> {
  bool showLogin = true;

  void toggleView() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return UsersLogin(
        showResigter: toggleView,
      );
    } else {
      return UsercreateAcct(
        showLogin: toggleView,
      );
    }
  }
}
