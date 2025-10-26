import 'package:flutter/material.dart';
import 'package:blackjack/widgets/betting_modal_sheet.dart';
import 'package:blackjack/widgets/brown_text.dart';

class BrownButton extends StatelessWidget {
  const BrownButton({
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
        fixedSize: Size(buttonLength, 80),
        backgroundColor: fancyDarkBrown,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        overlayColor: const Color.fromARGB(0, 0, 0, 0),
      ),
      child: BrownText(text: text, size: 30, weight: FontWeight.bold),
    );
  }
}
