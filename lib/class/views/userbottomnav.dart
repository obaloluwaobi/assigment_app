import 'package:assigment_app/class/views/home/userhome.dart';
import 'package:assigment_app/class/views/profile/userprofile.dart';
import 'package:assigment_app/class/views/submit/usersubmitted.dart';
import 'package:assigment_app/constants/constants.dart';
import 'package:flutter/material.dart';

class UserBottomNav extends StatefulWidget {
  const UserBottomNav({super.key});

  @override
  State<UserBottomNav> createState() => _UserBottomNavState();
}

class _UserBottomNavState extends State<UserBottomNav> {
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
            label: 'Submitted',
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
  const UserHomePage(),
  const UserSubmitted(),
  const UserProfile(),
];
