import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoomThemeWidget extends StatefulWidget {
  final String themeUrl;
  final String themeName;
  final Color textColor;
  const RoomThemeWidget(
      {super.key,
      required this.themeUrl,
      required this.themeName,
      required this.textColor});

  @override
  State<RoomThemeWidget> createState() => _RoomThemeWidgetState();
}

class _RoomThemeWidgetState extends State<RoomThemeWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(12.0).copyWith(top: 15, left: 14),
      child: Container(
        width: size.width * 0.32,
        height: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.themeUrl),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.only(top: 48.0),
          child: Text(
            "${widget.themeName}",
            style: GoogleFonts.arimo(fontSize: 16, color: widget.textColor),
          ),
        ),
      ),
    );
  }
}
