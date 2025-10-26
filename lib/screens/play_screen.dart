import 'package:blackjack/blackjack.dart';
import 'package:blackjack/widgets/big_white_text.dart';
import 'package:blackjack/widgets/gold_button.dart';
import 'package:blackjack/engine/game_engine.dart';
import 'package:blackjack/widgets/betting_modal_sheet.dart';
import 'package:blackjack/widgets/brown_text.dart';

import 'package:playing_cards/playing_cards.dart';
import 'package:flutter/material.dart';

int nrOfDecks = 1;

class PlayScreen extends StatefulWidget {
  const PlayScreen(this.homeScreen, this.initialBalance, {super.key});

  final void Function() homeScreen;
  final int initialBalance;

  @override
  State<PlayScreen> createState() {
    return _PlayScreenState();
  }
}

class _PlayScreenState extends State<PlayScreen> {
  List<PlayingCard> dealerCards = [];
  List<PlayingCard> playerCards = [];

  late GameEngine engine;

  bool showBackCard = true;

  bool _isPlayerTurn = true;

  Future<void> _openBettingModalSheet(BuildContext context) async {
    await showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (ctx) => BettingModalSheet(widget.homeScreen, engine),
    );
  }

  void isPlayerTurn() {
    setState(() {
      _isPlayerTurn = !_isPlayerTurn;
    });
  }

  void dealerDrawsCard(PlayingCard card) {
    setState(() {
      dealerCards.add(card);
    });
  }

  void playerDrawsCard(PlayingCard card) {
    setState(() {
      playerCards.add(card);
    });
  }

  void gameOver(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) => AlertDialog(
        actionsAlignment: MainAxisAlignment.spaceAround,
        title: Text(message, style: Theme.of(context).textTheme.bodyMedium),
        content: Text(
          'Play again ?',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                dealerCards = [];
                playerCards = [];
                showBackCard = true;
                _isPlayerTurn = true;
                WidgetsBinding.instance.addPostFrameCallback((_) async {
                  await _openBettingModalSheet(context);

                  engine.startGame();
                });
              });
              Navigator.pop(ctx);
            },
            child: Text("YES", style: Theme.of(context).textTheme.bodyMedium),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await Future.delayed(const Duration(milliseconds: 200));
              if (mounted) widget.homeScreen();
            },
            child: Text("HOME", style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 234, 224, 199),
      ),
    );
  }

  void dealerTurnCard() {
    setState(() {
      showBackCard = false;
    });
  }

  @override
  void initState() {
    super.initState();

    engine = GameEngine(
      nrOfDecks,
      dealerDrawsCard,
      playerDrawsCard,
      gameOver,
      0,
      0,
      dealerTurnCard,
      isPlayerTurn,
    );

    engine.balance = initialBalance.toDouble();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _openBettingModalSheet(context);

      engine.startGame();
    });
  }

  @override
  Widget build(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        BigWhiteText(text: "DEALER", size: 42, weight: FontWeight.w600),
        SizedBox(height: 20),
        SizedBox(
          height: 175,
          width: 255,
          child: FlatCardFan(
            children: [
              ...dealerCards.asMap().entries.map((entry) {
                int idx = entry.key;
                PlayingCard card = entry.value;
                return idx == 0
                    ? PlayingCardView(card: card, showBack: showBackCard)
                    : PlayingCardView(card: card);
              }),
            ],
          ),
        ),
        SizedBox(height: 22),
        BigWhiteText(
          text: "DEALER HITS ON 16 OR LESS",
          size: 20,
          weight: FontWeight.w600,
        ),
        SizedBox(height: 40),
        BigWhiteText(text: "YOU", size: 42, weight: FontWeight.w600),
        SizedBox(height: 20),
        SizedBox(
          height: 175,
          width: 255,
          child: FlatCardFan(
            children: [
              ...playerCards.map((card) {
                return PlayingCardView(card: card);
              }),
            ],
          ),
        ),
        SizedBox(height: 15),
        BigWhiteText(
          text: "Score: ${engine.playerScore}",
          size: 22,
          weight: FontWeight.bold,
        ),
        SizedBox(height: 25),
        Row(
          spacing: 25,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GoldButton(
              buttonLength: 150,
              navigation: _isPlayerTurn ? engine.playerHit : () {},
              text: "HIT",
            ),
            GoldButton(
              buttonLength: 150,
              navigation: _isPlayerTurn ? engine.playerStand : () {},
              text: "STAND",
            ),
          ],
        ),
        SizedBox(height: 10),
        TextButton.icon(
          onPressed: widget.homeScreen,
          icon: Icon(Icons.home, color: Colors.white),
          label: BigWhiteText(
            text: "HOME",
            size: 20,
            weight: FontWeight.normal,
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(color: fancyLightBrown),
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BrownText(
                    text:
                        "BALANCE: ${engine.balance == engine.balance.roundToDouble() ? engine.balance.toInt() : engine.balance}",
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                  BrownText(
                    text:
                        "BET: ${engine.bet == engine.bet.roundToDouble() ? engine.bet.toInt() : engine.bet}",
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
