import 'package:blackjack/widgets/gold_button.dart';
import 'package:blackjack/widgets/big_white_text.dart';

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen(this.rulesScreen, this.playScreen ,{super.key});

  final void Function() rulesScreen;
  final void Function() playScreen;

  @override
  Widget build(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigWhiteText(text: 'BLACKJACK', size: 52, weight: FontWeight.w600),
        const SizedBox(height: 5,),
        Image.asset(
          'assets/images/casino.png',
          width: 150,
          color: Colors.white,
        ),
        const SizedBox(height: 180,),
        GoldButton(buttonLength: 150, navigation: playScreen, text: "PLAY"),
        const SizedBox(height: 20,),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            overlayColor: const Color.fromARGB(0, 0, 0, 0)
          ),
          onPressed: rulesScreen,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: BigWhiteText(text: "RULES", size: 25, weight: FontWeight.w500),
          )
        )
      ],
    );
  }
}