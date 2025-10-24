import 'package:blackjack/widgets/scrollable_rule_list.dart';
import 'package:blackjack/widgets/tips_modal_sheet.dart';
import 'package:blackjack/widgets/gold_button.dart';
import 'package:blackjack/widgets/big_white_text.dart';

import 'package:flutter/material.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen(this.homeScreen, {super.key});

  final void Function() homeScreen;

  void _openTipsModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => const TipsModalSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BigWhiteText(text: "RULES", size: 50, weight: FontWeight.w600),
        const SizedBox(height: 40),
        ScrollableRuleList(),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoldButton(buttonLength: 150, navigation: homeScreen, text: "BACK"),
            SizedBox(width: 20),
            GoldButton(
              buttonLength: 150,
              navigation: () => _openTipsModalSheet(context),
              text: "TIPS",
            ),
          ],
        ),
      ],
    );
  }
}
