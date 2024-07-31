import 'package:assigment_app/admin/views/home/home.dart';
import 'package:assigment_app/admin/views/profile/profile.dart';
import 'package:assigment_app/admin/views/submissions/submissions.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:flutter/material.dart';

class AdminbottomNav extends StatefulWidget {
  const AdminbottomNav({super.key});

  @override
  State<AdminbottomNav> createState() => _AdminbottomNavState();
}

class _AdminbottomNavState extends State<AdminbottomNav> {
  int selectedIndex = 0;
  navigetoPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) => navigetoPage(index),
        // showSelectedLabels: false,
        type: BottomNavigationBarType.fixed,
        backgroundColor: background, selectedLabelStyle: size16,
        selectedItemColor: dark,
        unselectedLabelStyle: size14,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: const Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(
              Icons.home_outlined,
              color: dark,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Submissions',
            icon: const Icon(
              Icons.book_outlined,
              // color: dark,
            ),
            activeIcon: Icon(
              Icons.book_outlined,
              color: dark,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: const Icon(
              Icons.person_outline,
            ),
            activeIcon: Icon(
              Icons.person_outline,
              color: dark,
            ),
          ),
        ],
      ),
      body: pages[selectedIndex],
    );
  }
}

final List<Widget> pages = [
  const AdminHomePage(),
  const AdminStudentSubmission(),
  const AdminProfilePage(),
];
