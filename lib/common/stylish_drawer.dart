import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/choose_book/choose_book_screen.dart';
import '../features/code_redeem/code_redeemtion_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/room_creation/room_creation_screen.dart';
import '../features/room_preview/room_preview_screen.dart';
import '../features/auth/screens/signIn_screen.dart';
import '../utils/move_screen.dart';
import 'constants/constants.dart';

Widget buildStylishDrawer(BuildContext context) {
  Color primaryPurple = Color(0xffB2A4FF);
  Color secondaryPeach = Color(0xffFFB4B4);
  Color beige = Color(0xffFFDEB4);

  return Drawer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryPurple, secondaryPeach],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
            decoration: BoxDecoration(
<<<<<<< HEAD
              color: primaryPurple,
=======
              color: beige,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage(
                      'assets/profile_image.png'), // Add your profile image asset
                ),
                SizedBox(height: 10.0),
                Text(
                  userName ?? "Guest User",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentUserEmail ?? "",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
            thickness: 3,
          ),
          // ListTiles for different options
          // You can customize the icons and text as needed
          buildDrawerTile(
              Icons.home, 'Home', () => moveScreen(context, HomeScreen())),
          buildDrawerTile(Icons.person, 'Profile',
              () => moveScreen(context, ProfileScreen())),
          buildDrawerTile(Icons.book_outlined, 'Choose Book',
              () => moveScreen(context, ChooseBooksScreen())),
          buildDrawerTile(Icons.roofing, 'Create Room',
              () => moveScreen(context, RoomCreationScreen())),
          buildDrawerTile(Icons.roofing, 'Redeem a Code',
              () => moveScreen(context, CodeRedemptionScreen())),
          buildDrawerTile(Icons.logout, 'Logout', () {
            FirebaseAuth.instance.signOut();
            moveScreen(context, SignInScreen());
          }),
        ],
      ),
    ),
  );
}

Widget buildDrawerTile(IconData icon, String title, void onTap()) {
  return ListTile(
    leading: Icon(icon, color: Colors.white),
    title: Text(
      title,
      style: TextStyle(color: Colors.white),
    ),
    onTap: onTap,
    contentPadding:
        EdgeInsets.symmetric(horizontal: 16.0), // Add some horizontal padding
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.0)), // Add rounded corners
    hoverColor: Colors
        .white24, // Change the background color when the tile is hovered over
    focusColor:
        Colors.white24, // Change the background color when the tile is focused
    selectedTileColor:
        Colors.white24, // Change the background color when the tile is selected
    enableFeedback:
        true, // Enable haptic feedback when the tile is tapped or long-pressed
    horizontalTitleGap:
        8.0, // Reduce the gap between the leading icon and the title text
    minVerticalPadding:
        8.0, // Increase the vertical padding to make the tiles taller
    visualDensity: VisualDensity
        .compact, // Reduce the visual density to make the tiles more compact
  );
}
