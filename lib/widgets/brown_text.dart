import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrownText extends StatelessWidget {
  const BrownText({
    required this.text,
    required this.size,
    required this.weight,
    super.key,
  });

  final String text;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.merriweather(
        color: const Color.fromARGB(255, 222, 210, 159),
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}