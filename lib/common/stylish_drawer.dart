import 'package:book_verse/common/constants/constants.dart';
import 'package:book_verse/features/auth/screens/signIn_screen.dart';
import 'package:book_verse/features/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../features/choose_book/choose_book_screen.dart';
import '../features/code_redeem/code_redeemtion_screen.dart';
import '../features/home/home_screen.dart';
import '../features/room_creation/room_creation_screen.dart';
import '../features/room_preview/room_preview_screen.dart';
import '../utils/move_screen.dart';

Widget buildStylishDrawer(BuildContext context) {
  Color primaryGreen = const Color.fromARGB(255, 170, 198, 241);
  Color secondaryGreen = const Color.fromARGB(255, 129, 115, 207);
  Color headerGreen = const Color.fromARGB(255, 74, 68, 248);

  return Drawer(
    child: Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                primaryGreen,
                secondaryGreen,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
              decoration: BoxDecoration(
                color: headerGreen,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50.0,
                    backgroundImage: AssetImage(''),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    currentUserName ?? "name",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    currentUserEmail ?? "email",
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Colors.white,
              ),
              title: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                moveScreen(context, const HomeScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Colors.white,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                moveScreen(context, const ProfileScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.book_outlined,
                color: Colors.white,
              ),
              title: const Text(
                'Choose book',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                moveScreen(context, ChooseBooksScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.roofing,
                color: Colors.white,
              ),
              title: const Text(
                'Create room',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                moveScreen(context, RoomCreationScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.roofing,
                color: Colors.white,
              ),
              title: const Text(
                'Redeem a Code',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                moveScreen(context, CodeRedemptionScreen());
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                FirebaseAuth.instance.signOut();
                moveScreen(context, const SignInScreen());
              },
            ),
          ],
        ),
      ],
    ),
  );
}
