import 'package:flutter/material.dart';

import 'package:blackjack/blackjack.dart';
import 'package:blackjack/widgets/chips_button.dart';
import 'package:blackjack/widgets/brown_text.dart';
import 'package:blackjack/widgets/brown_button.dart';
import 'package:blackjack/widgets/betting_modal_sheet.dart';

class PreferencesScreen extends StatefulWidget {
  const PreferencesScreen(this.homeScreen, this.gameData, {super.key});

  final void Function() homeScreen;
  final GameData gameData;

  @override
  State<PreferencesScreen> createState() => _PreferencesScreenState();
}

class _PreferencesScreenState extends State<PreferencesScreen> {
  bool _isPlayerAdding = true;
  void addingBet() {
    setState(() {
      _isPlayerAdding = !_isPlayerAdding;
    });
  }

  void changeBet(bool isPlayerAdding, final int chipValue) {
    setState(() {
      isPlayerAdding
          ? widget.gameData.balance += chipValue
          : widget.gameData.balance -= chipValue;
    });
  }

  void setBalance(double setInitialBalance) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(
          child: BrownText(
            text: "BALANCE SET",
            size: 30,
            weight: FontWeight.bold,
          ),
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: fancyDarkBrown,
      ),
    );
    widget.gameData.saveBalance(widget.gameData.balance);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      child: Column(
        spacing: 20,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          BrownText(text: "INITIAL BALANCE", size: 30, weight: FontWeight.bold),
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
                  onPressed: !_isPlayerAdding ? () {} : addingBet,
                  icon: Icon(Icons.remove),
                  color: !_isPlayerAdding ? goldColor : darkGoldColor,
                  iconSize: 50,
                ),
                Spacer(),
                BrownText(
                  text:
                      "\$${widget.gameData.balance == widget.gameData.balance.roundToDouble() ? widget.gameData.balance.toInt() : widget.gameData.balance}",
                  size: 46,
                  weight: FontWeight.bold,
                ),
                Spacer(),
                IconButton(
                  onPressed: _isPlayerAdding ? () {} : addingBet,
                  icon: Icon(Icons.add),
                  color: _isPlayerAdding ? goldColor : darkGoldColor,
                  iconSize: 50,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            spacing: 0,
            children: [
              ChipsButton(
                82,
                82,
                image: 'assets/images/chips-1.png',
                onPressed: () {
                  changeBet(_isPlayerAdding, 1);
                },
              ),
              ChipsButton(
                94,
                94,
                image: 'assets/images/chips-5.png',
                onPressed: () {
                  changeBet(_isPlayerAdding, 5);
                },
              ),
              ChipsButton(
                95,
                95,
                image: 'assets/images/chips-25.png',
                onPressed: () {
                  changeBet(_isPlayerAdding, 25);
                },
              ),
              ChipsButton(
                92,
                92,
                image: 'assets/images/chips-100.png',
                onPressed: () {
                  changeBet(_isPlayerAdding, 100);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BrownButton(
                buttonLength: 170,
                navigation: () {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  widget.homeScreen();
                },
                text: 'HOME',
              ),
              BrownButton(
                buttonLength: 170,
                navigation: () {
                  setBalance(widget.gameData.balance);
                },
                text: 'SET',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
