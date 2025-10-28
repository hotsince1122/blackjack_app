import 'package:blackjack/blackjack.dart';
import 'package:blackjack/models/playing_card.dart';
import 'package:playing_cards/playing_cards.dart';

class GameEngine {
  GameEngine(
    this.nrOfDecks,
    this.addCardToUI,
    this.gameOver,
    this.dealerTurnCard,
    this.isPlayerTurn,
    this.gameData,
  ) {
    deck = [];

    for (var value in CardValue.values) {
      for (int j = 0; j < nrOfDecks; j++) {
        for (var suit in Suit.values) {
          if (value != CardValue.joker_1 && value != CardValue.joker_2) deck.add(PlayingCard(suit, value));
        }
      }
    }
    deck.shuffle();
  }

  final GameData gameData;

  final int nrOfDecks;
  late List<PlayingCard> deck;

  final void Function(PlayingCard, bool) addCardToUI;
  final void Function(String) gameOver;
  final void Function() dealerTurnCard;
  final void Function() isPlayerTurn;

  Hand player = Hand();
  Hand dealer = Hand();

  int playerScore = 0;
  int dealerScore = 0;

  double bet = 100;

  Future<void> engineDrawCard({required bool isPlayer}) async {
    await Future.delayed(const Duration(milliseconds: 600));

    if (isPlayer) {
      player.drawCard(deck.last);
      playerScore = player.getTotal();
      addCardToUI(player.lastCard, true);
    } else {
      dealer.drawCard(deck.last);
      dealerScore = dealer.getTotal();
      addCardToUI(dealer.lastCard, false);
    }

    deck.removeLast();
  }

  void handleWinPayout ({required double multiplier, required bool playerWon}) {
    playerWon ? gameData.balance += bet * multiplier : gameData.balance -= bet;
    gameData.saveBalance(gameData.balance);
    bet = 100;
  }
  

  Future<void> startGame() async {
    player.hand.clear();
    dealer.hand.clear();

    playerScore = 0;
    dealerScore = 0;

    for (int i = 0; i < 2; i++) {
      await engineDrawCard(isPlayer: true);
      await engineDrawCard(isPlayer: false);
    }

    if (player.isBlackjack()) {
      handleWinPayout(multiplier: 1.5, playerWon: true);
      gameOver('You won!');
      return;
    }
  }

  void playerStand() {
    isPlayerTurn();
    playerScore = player.getTotal();

    dealerTurn();
  }

  Future<void> playerHit() async {
    isPlayerTurn();

    await engineDrawCard(isPlayer: true);

    await Future.delayed(const Duration(milliseconds: 600));

    if (player.isBlackjack()) {
      handleWinPayout(multiplier: 1, playerWon: true);
      gameOver('You won!');
      return;
    }

    if (player.getTotal() > 21) {
      handleWinPayout(multiplier: 1, playerWon: false);
      gameOver('Dealer won!');
      return;
    }

    isPlayerTurn();
  }

  Future<void> dealerTurn() async {
    await Future.delayed(const Duration(milliseconds: 600));
    dealerTurnCard();

    while (dealer.getTotal() < 17) {
      await engineDrawCard(isPlayer: false);
    }

    await Future.delayed(const Duration(milliseconds: 600));

    if (dealerScore > 21) {
      handleWinPayout(multiplier: 1, playerWon: true);
      gameOver('Player won!');
      return;
    }

    checkWinner();
  }

  void checkWinner() {
    if (dealerScore == playerScore) {
      bet = 100;
      gameOver('Push!');
    } else if (dealerScore > playerScore) {
      handleWinPayout(multiplier: 1, playerWon: false);
      gameOver('Dealer won!');
    } else {
      handleWinPayout(multiplier: 1, playerWon: true);
      gameOver('You won!');
    }
  }
}
