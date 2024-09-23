import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KemetLogoText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;

  const KemetLogoText({
    super.key,
    required this.text,
    this.fontSize = 72,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.yatraOne(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 10,
        shadows: [
          for (double i = 1; i < 4; i++)
            Shadow(
              color: const Color.fromARGB(255, 52, 20, 58).withOpacity(0.3),
              blurRadius: 3 * i,
              offset: Offset(i, i),
            ),
        ],
      ),
    );
  }
}
