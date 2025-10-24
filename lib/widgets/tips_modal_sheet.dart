import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:blackjack/data/tips.dart';
import 'package:blackjack/blackjack.dart';

class TipsModalSheet extends StatelessWidget {
  const TipsModalSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 450,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: goldColor,
      ),
      child: Container(
        margin: EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "BLACKJACK TIPS",
                  style: GoogleFonts.merriweather(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_downward_outlined,
                    color: Colors.black,
                    size: 33,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            SizedBox(
              child: Column(
                spacing: 15,
                children: tips.asMap().entries.map((entry) {
                  int idx = entry.key;
                  String tip = entry.value;
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      icons[idx],
                      const SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          tip,
                          style: GoogleFonts.merriweather(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
