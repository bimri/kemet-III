import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KemetButtonText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;

  const KemetButtonText({
    super.key,
    required this.text,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.raleway(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
