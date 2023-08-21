import 'package:flutter/material.dart';

import '../../../utils/move_screen.dart';
import '../../choose_book/choose_book_screen.dart';
import '../../database/controllers/database_controller.dart';
import '../../database/models/room.dart';

class MyAnimatedButton extends StatefulWidget {
  @override
  _MyAnimatedButtonState createState() => _MyAnimatedButtonState();
}

class _MyAnimatedButtonState extends State<MyAnimatedButton> {
  bool _isPressed = false;

  void _toggleButtonState() {
    setState(() {
      _isPressed = !_isPressed;
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
