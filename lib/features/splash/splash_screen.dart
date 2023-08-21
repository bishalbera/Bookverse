import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:book_verse/features/onBoarding/onBoarding_screen.dart';
import 'package:book_verse/utils/gradient_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: GradientText(
          text: "Bookverse",
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
      nextScreen: const OnBoardingScreen(),
    );
  }
}
