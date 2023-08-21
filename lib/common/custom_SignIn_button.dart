import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSignInButton extends StatefulWidget {
  const CustomSignInButton({super.key});

  @override
  State<CustomSignInButton> createState() => _CustomSignInButtonState();
}

class _CustomSignInButtonState extends State<CustomSignInButton> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.065,
      width: double.infinity,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: Colors.lime.shade400,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        "Sign In",
        style: GoogleFonts.roboto(
          color: Colors.black,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
