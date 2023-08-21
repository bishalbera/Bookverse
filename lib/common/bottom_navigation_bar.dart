import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/choose_book/choose_book_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../utils/move_screen.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({super.key});

  @override
  State<MyCustomBottomNavigationBar> createState() =>
      _MyCustomBottomNavigationBarState();
}

class _MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.book_outlined,
                text: 'Read books',
              ),
              // GButton(
              //   icon: Icons.redeem,
              //   text: 'Code redeem',
              // ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;

                if (selectedIndex == 0) {
                  moveScreen(context, const HomeScreen());
                } else if (selectedIndex == 1) {
                  moveScreen(context, ChooseBooksScreen());
                } else if (selectedIndex == 2) {
                  moveScreen(context, ProfileScreen());
                }
              });
            },
          ),
        ),
      ),
    );
  }
}
