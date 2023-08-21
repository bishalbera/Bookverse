import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/stylish_drawer.dart';
import '../../utils/appBar.dart';
import '../../utils/move_screen.dart';
import '../room_details/room_details_screens.dart';

class RoomCreationScreen extends StatefulWidget {
  @override
  _RoomCreationScreenState createState() => _RoomCreationScreenState();
}

class _RoomCreationScreenState extends State<RoomCreationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: makeAppBar(context),
      drawer: buildStylishDrawer(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create a new room',
              style: GoogleFonts.poppins(
                fontSize: 28,
              ),
            ),
            SizedBox(height: 40),
            AnimatedButton(),
          ],
        ),
      ),
    );
  }
}

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // Adjusted duration
      vsync: this,
      lowerBound: 0.0,
      upperBound: 0.05, // Adjusted upperBound
    )..addListener(() {
        setState(() {});
      });
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95, // Adjusted end value
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut, // Use a curve for smoother animation
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    moveScreen(context, RoomDetailsScreen());
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      child: Transform.scale(
        scale: _scaleAnimation.value,
        child: Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Adjusted shadow opacity
                offset: Offset(5.0, 5.0),
                blurRadius: 10.0, // Adjusted blur radius
              ),
            ],
          ),
          child: Text(
            'Create',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
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
      home: RoomCreationScreen(),
    );
  }
}
