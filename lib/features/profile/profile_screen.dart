import 'package:book_verse/features/guide/screens/guide_screen.dart';
import 'package:book_verse/features/settings/screens/settings_screen.dart';
import 'package:book_verse/features/wallet/screens/wallet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/bottom_navigation_bar.dart';
import '../../common/constants/constants.dart';
import '../../common/stylish_drawer.dart';
import '../../utils/move_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String formattedDate;
  String myUserName = "";

  @override
  void initState() {
    super.initState();
    var data = firestore
        .collection('users')
        .doc(firebaseAuth.currentUser?.uid ?? '')
        .get()
        .then((DocumentSnapshot snapshot) {
      myUserName = snapshot.get('name');
      setState(() {
        print(myUserName);
      });
    });
    formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                        'https://media.discordapp.net/attachments/1091713413106901112/1143208237173321738/image.png?width=66&height=88',
                      ),
                      radius: 30,
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello,",
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          myUserName,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          formattedDate,
                          style: GoogleFonts.roboto(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(height: 30),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        moveScreen(context, GlassCard());
                      },
                      child: ProfileWidget(
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.blue,
                        ),
                        text: "Your wallet",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        moveScreen(context, GuideScreen());
                      },
                      child: ProfileWidget(
                        icon: const Icon(
                          Icons.info,
                          color: Colors.blue,
                        ),
                        text: "App Info",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        moveScreen(context, SettingsScreen());
                      },
                      child: ProfileWidget(
                        icon: const Icon(Icons.settings),
                        text: "Settings",
                      ),
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      endIndent: 0,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ProfileWidget(
                      icon: const Icon(
                        Icons.logout,
                        color: Colors.grey,
                      ),
                      text: "Log Out",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final Icon icon;
  final String text;

  const ProfileWidget({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfileScreen(),
    );
  }
}
