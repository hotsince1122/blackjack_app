import 'package:flutter/material.dart';

import 'package:blackjack/blackjack.dart';
import 'package:blackjack/engine/game_engine.dart';
import 'package:blackjack/widgets/chips_button.dart';
import 'package:blackjack/widgets/brown_text.dart';
import 'package:blackjack/widgets/brown_button.dart';

Color fancyLightBrown = Color.fromARGB(255, 101, 63, 26);
Color fancyDarkBrown = Color.fromARGB(255, 89, 54, 21);

Color darkGoldColor = const Color.fromARGB(255, 88, 72, 30);

Future<void> goHomeScreen(
  BuildContext context,
  final void Function() homeScreen,
) async {
  Navigator.pop(context);
  await Future.delayed(Duration(milliseconds: 260));
  homeScreen();
}

class BettingModalSheet extends StatefulWidget {
  const BettingModalSheet(this.homeScreen, this.engine, this.gameData, {super.key});

  final void Function() homeScreen;
  final GameEngine engine;
  final GameData gameData;

  @override
  State<BettingModalSheet> createState() {
    return _BettingModalSheet();
  }
}

class _BettingModalSheet extends State<BettingModalSheet> {
  bool _isPlayerAdding = true;

  void addingBet() {
    setState(() {
      _isPlayerAdding = !_isPlayerAdding;
    });
  }

  void changeBet(GameEngine engine, bool isPlayerAdding, final int chipValue) {
    setState(() {
      isPlayerAdding ? engine.bet += chipValue : engine.bet -= chipValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
      width: double.infinity,
      height: 460,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: fancyLightBrown,
      ),
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              BrownText(
                text: "PLACE YOUR BET",
                size: 32,
                weight: FontWeight.bold,
              ),
              BrownText(
                text: "BALANCE: ${widget.gameData.balance == widget.gameData.balance.roundToDouble() ? widget.gameData.balance.toInt() : widget.gameData.balance}",
                size: 18,
                weight: FontWeight.bold,
              ),
            ],
          ),
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
                      "\$${widget.engine.bet == widget.engine.bet.roundToDouble() ? widget.engine.bet.toInt() : widget.engine.bet}",
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
                  changeBet(widget.engine, _isPlayerAdding, 1);
                },
              ),
              ChipsButton(
                94,
                94,
                image: 'assets/images/chips-5.png',
                onPressed: () {
                  changeBet(widget.engine, _isPlayerAdding, 5);
                },
              ),
              ChipsButton(
                95,
                95,
                image: 'assets/images/chips-25.png',
                onPressed: () {
                  changeBet(widget.engine, _isPlayerAdding, 25);
                },
              ),
              ChipsButton(
                92,
                92,
                image: 'assets/images/chips-100.png',
                onPressed: () {
                  changeBet(widget.engine, _isPlayerAdding, 100);
                },
              ),
            ],
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BrownButton(
                  buttonLength: 170,
                  navigation: () {
                    goHomeScreen(context, widget.homeScreen);
                  },
                  text: 'HOME',
                ),
                BrownButton(
                  buttonLength: 170,
                  navigation: () {
                    widget.gameData.saveBalance(widget.gameData.balance - widget.engine.bet);
                    Navigator.pop(context);
                  },
                  text: 'BET',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
