// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../common/constants/constants.dart';
import '../../../utils/move_screen.dart';
import '../../choose_book/choose_book_screen.dart';
import '../../database/controllers/database_controller.dart';
import '../../database/models/room.dart';

class MyAnimatedButton extends StatefulWidget {
  final String roomName;
  final String roomCode;
  final String selectedImageUrl;
  const MyAnimatedButton({
    Key? key,
    required this.roomName,
    required this.roomCode,
    required this.selectedImageUrl,
  }) : super(key: key);
  @override
  _MyAnimatedButtonState createState() => _MyAnimatedButtonState();
}

class _MyAnimatedButtonState extends State<MyAnimatedButton> {
  bool _isPressed = false;

  void _toggleButtonState() {
    setState(() {
      DataBaseController controller = DataBaseController();

      RoomModel model = RoomModel(
          name: widget.roomName,
          roomCode: widget.roomCode,
          participants: [firebaseAuth.currentUser?.uid ?? ''],
          roomTheme: widget.selectedImageUrl,
          createdByUid: firebaseAuth.currentUser?.uid ?? '');

      controller.createRoomInFirebase(context, model);
      moveScreen(context, ChooseBooksScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleButtonState,
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.symmetric(horizontal: 130),
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: _isPressed ? 150.0 : 140.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: _isPressed ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(_isPressed ? 30.0 : 25.0),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            'Join',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
