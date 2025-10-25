import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:blackjack/blackjack.dart';

Color fancyLightBrown = Color.fromARGB(255, 101, 63, 26);
Color fancyDarkBrown = Color.fromARGB(255, 89, 54, 21);

class ChipsButton extends StatelessWidget {
  const ChipsButton({required this.image, super.key});

  final String image;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      padding: EdgeInsets.zero, // scoate spațiul intern implicit
      constraints: BoxConstraints(minWidth: 0, minHeight: 0),
      onPressed: () {},
      icon: Image.asset(image, width: 85, height: 85),
    );
  }
}

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

class BettingModalSheet extends StatefulWidget {
  const BettingModalSheet({super.key});

  @override
  State<BettingModalSheet> createState() {
    return _BettingModalSheet();
  }
}

class _BettingModalSheet extends State<BettingModalSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: fancyLightBrown,
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BrownText(text: "PLACE YOUR BET", size: 30, weight: FontWeight.bold),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
            width: double.infinity,
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: fancyDarkBrown,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.remove),
                  color: goldColor,
                  iconSize: 50,
                ),
                Spacer(),
                BrownText(text: "\$100", size: 46, weight: FontWeight.bold),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  color: goldColor,
                  iconSize: 50,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 0,
            children: [
              ChipsButton(image: 'assets/images/chips-1.png'),
              ChipsButton(image: 'assets/images/chips-5.png'),
              ChipsButton(image: 'assets/images/chips-25.png'),
              ChipsButton(image: 'assets/images/chips-100.png'),
            ],
          ),
        ],
      ),
    );
  }
}
