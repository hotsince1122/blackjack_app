import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class BigWhiteText extends StatelessWidget {
  const BigWhiteText({required this.text, required this.size, required this.weight, super.key});

  final String text;
  final double size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.merriweather(
        color: Colors.white,
        fontSize: size,
        fontWeight: weight,
      ),
    );
  }
}
