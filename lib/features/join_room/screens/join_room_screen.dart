import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_verse/utils/show_snackBar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';
import '../../room_preview/room_preview_screen.dart';

class JoinRoomScreen extends StatefulWidget {
  const JoinRoomScreen({Key? key}) : super(key: key);

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _roomCodeController = TextEditingController();
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      });
    _animationController.forward();
  }

  @override
  void dispose() {
    _roomCodeController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void joinRoom() async {
    String roomCode = _roomCodeController.text;

    // Check if the room with the provided room code exists in Firestore
    final roomSnapshot = await FirebaseFirestore.instance
        .collection('rooms')
        .doc(roomCode)
        .get();

    if (roomSnapshot.exists) {
      // Add the user's UID to the participants list
      final participantUids =
          List<String>.from(roomSnapshot.data()!['participants']);
      participantUids.add(FirebaseAuth.instance.currentUser?.uid ?? '');

      // Update the participants field in Firestore
      await FirebaseFirestore.instance
          .collection('rooms')
          .doc(roomCode)
          .update({'participants': participantUids});

      // Navigate to the RoomPreviewScreen with the provided room code
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RoomPreviewScreen(roomCode: roomCode),
        ),
      );
    } else {
      showSnackBar(context, "Failure",
          "Sorry, but no room exists with that code.", ContentType.warning);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Room'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.rotate(
                    angle: _animation.value * 6.3,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          Icons.flash_on,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Enter the room code to join",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _roomCodeController,
                        decoration: InputDecoration(
                          hintText: 'Enter room code',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.emoji_emotions, color: Colors.brown),
                  ],
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: joinRoom,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  textStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  elevation: 3,
                  shadowColor: Colors.black.withOpacity(0.2),
                ),
                child: Text('Join'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
