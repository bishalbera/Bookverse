import 'package:book_verse/features/join_room/screens/join_room_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../common/bottom_navigation_bar.dart';
import '../../common/stylish_drawer.dart';
import '../../utils/appBar.dart';
import '../../utils/move_screen.dart';
import '../room_creation/room_creation_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _greeting = "";
  String _formattedDate = "";
  String _featuredBookTitle =
      "The Book of the Month"; // Replace with actual data
  List<String> _recommendedBooks = [
    "Book 1",
    "Book 2",
    "Book 3"
  ]; // Replace with actual data

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    DateTime now = DateTime.now();

    if (now.hour < 12) {
      _greeting = "Good Morning, Armaan! 👋🏻";
    } else if (now.hour < 18) {
      _greeting = "Good Afternoon, Armaan! 👋🏻";
    } else {
      _greeting = "Good Evening, Armaan! 👋🏻";
    }

    _formattedDate = DateFormat("d MMMM, yyyy").format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyCustomBottomNavigationBar(),
      drawer: buildStylishDrawer(context),
      appBar: makeAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1489549132488-d00b7eee80f1?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _greeting,
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      _formattedDate,
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 24.0), // Increased spacing
                    Text(
                      "Featured Book of the Month",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 80),
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage("assets/book_cover.jpg"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _featuredBookTitle,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0.0),
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Read it")),
                      ),
                    ),
                    SizedBox(height: 24.0), // Increased spacing
                    Text(
                      "Personalized Recommendations",
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _recommendedBooks.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            elevation: 3,
                            margin: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Container(
                              width: 100,
                              child: Center(
                                child: Text(
                                  _recommendedBooks[index],
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 32.0), // Increased spacing
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Improved button alignment
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(primary: Colors.blue),
                          onPressed: () {
                            // Action for "Create a Private Room" button
                            moveScreen(context, RoomCreationScreen());
                          },
                          child: Text(
                            "Create a Private Room",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.blueAccent),
                          onPressed: () {
                            moveScreen(context, JoinRoomScreen());
                          },
                          child: Text(
                            "Join a Room",
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
