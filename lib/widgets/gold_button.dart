import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:blackjack/blackjack.dart';

class GoldButton extends StatelessWidget {
  const GoldButton({
    required this.buttonLength,
    required this.navigation,
    required this.text,
    super.key,
  });

  final double buttonLength;
  final void Function() navigation;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: navigation,
      style: TextButton.styleFrom(
        fixedSize: Size.fromWidth(buttonLength),
        backgroundColor: goldColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        overlayColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      child: Text(
        text,
        style: GoogleFonts.merriweather(
          color: darkGreenColor,
          fontSize: 30,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
