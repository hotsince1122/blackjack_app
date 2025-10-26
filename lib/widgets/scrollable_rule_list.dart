import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:blackjack/data/rules.dart';

class ScrollableRuleList extends StatelessWidget {
  const ScrollableRuleList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 370,
      child: SingleChildScrollView(
        child: Column(
          children: rules.asMap().entries.map((entry) {
            int idx = entry.key;
            String rule = entry.value;
            return Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
              child: Card(
                color: Color.fromARGB(255, 234, 224, 199),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                        child: Container(
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22.5),
                          ),
                          child: Center(
                            child: Text(
                              '${idx + 1}',
                              style: GoogleFonts.merriweather(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          rule,
                          style: GoogleFonts.merriweather(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
