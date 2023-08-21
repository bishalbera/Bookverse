import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget? makeAppBar(
  BuildContext context, {
  Color bgColor = Colors.transparent,
  String title = "Bookverse",
  Color fontColor = Colors.black,
}) {
  return AppBar(
    title: Text(
      "TheBookVerse",
      style: GoogleFonts.poppins(color: fontColor, fontSize: 18),
    ),
    backgroundColor: bgColor,
    elevation: 0,
    centerTitle: true,
  );
}
