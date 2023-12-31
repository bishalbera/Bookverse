import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_verse/features/home/home_screen.dart';
import 'package:book_verse/features/onBoarding/onBoarding_screen.dart';
import 'package:book_verse/utils/gradient_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import '../../common/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    if (firebaseAuth.currentUser != null) {
      var data = firestore
          .collection('users')
          .doc(firebaseAuth.currentUser?.uid ?? '')
          .get()
          .then((DocumentSnapshot snapshot) {
        userName = snapshot.get('name');
        setState(() {});
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: GradientText(
          text: "TheBookVerse",
          gradient:
              const LinearGradient(colors: [Colors.blue, Colors.redAccent]),
          style: GoogleFonts.poppins(
            fontSize: 42,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center),
      backgroundColor: Colors.black12,
      animationDuration: const Duration(seconds: 5),
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.theme,
      nextScreen: FirebaseAuth.instance.currentUser != null
          ? const HomeScreen()
          : const OnBoardingScreen(),
    );
  }
}
