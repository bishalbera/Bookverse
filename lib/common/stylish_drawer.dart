import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/choose_book/choose_book_screen.dart';
import '../features/code_redeem/code_redeemtion_screen.dart';
import '../features/home/home_screen.dart';
import '../features/join_room/screens/join_room_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/room_creation/room_creation_screen.dart';
import '../features/auth/screens/signIn_screen.dart';
import '../features/rooms/screens/rooms_screen.dart';
import '../utils/move_screen.dart';
import 'constants/constants.dart';

Widget buildStylishDrawer(BuildContext context) {
  const Color primaryPurple = Color(0xffB2A4FF);
  const Color secondaryPeach = Color(0xffFFB4B4);
  const Color beige = Color(0xffFFDEB4);

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
              color: beige,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: NetworkImage(
                      'https://media.discordapp.net/attachments/1091713413106901112/1143208237173321738/image.png?width=66&height=88'), // Add your profile image asset
                ),
                const SizedBox(height: 10.0),
                Text(
                  userName ?? "Guest User",
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currentUserEmail ?? "",
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
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
          buildDrawerTile(Icons.home, 'Home',
              () => moveScreen(context, const HomeScreen())),
          buildDrawerTile(Icons.library_books, 'Rooms',
              () => moveScreen(context, RoomsScreen())),
          buildDrawerTile(Icons.person, 'Profile',
              () => moveScreen(context, const ProfileScreen())),
          buildDrawerTile(Icons.book_outlined, 'Choose Book',
              () => moveScreen(context, ChooseBooksScreen())),
          buildDrawerTile(Icons.roofing, 'Create a Room',
              () => moveScreen(context, RoomCreationScreen())),
          buildDrawerTile(Icons.roofing, 'Join a Room',
              () => moveScreen(context, const JoinRoomScreen())),
          buildDrawerTile(Icons.roofing, 'Redeem a Code',
              () => moveScreen(context, const CodeRedemptionScreen())),
          buildDrawerTile(Icons.logout, 'Logout', () {
            FirebaseAuth.instance.signOut();
            moveScreen(context, const SignInScreen());
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
      style: const TextStyle(color: Colors.white),
    ),
    onTap: onTap,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
    hoverColor: Colors
        .white24, // Change the background color when the tile is hovered over
    focusColor: Colors.white24,
    selectedTileColor: Colors.white24,
    enableFeedback: true,
    horizontalTitleGap: 8.0,
    minVerticalPadding: 8.0,
    visualDensity: VisualDensity.compact,
  );
}
