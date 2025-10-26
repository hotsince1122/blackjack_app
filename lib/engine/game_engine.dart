import 'package:blackjack/models/playing_card.dart';
import 'package:playing_cards/playing_cards.dart';

class GameEngine {
  GameEngine(
    this.nrOfDecks,
    this.dealerDrawsCard,
    this.playerDrawsCard,
    this.gameOver,
    this.playerScore,
    this.dealerScore,
    this.dealerTurnCard,
    this.isPlayerTurn,
  ) {
    deck = [];

    for (var value in CardValue.values) {
      for (int j = 0; j < nrOfDecks; j++) {
        for (var suit in Suit.values) {
          if(value != CardValue.joker_1 && value != CardValue.joker_2) deck.add(PlayingCard(suit, value));
        }
      }
    }
    deck.shuffle();
  }


  final int nrOfDecks;
  late List<PlayingCard> deck;

  final void Function(PlayingCard) dealerDrawsCard;
  final void Function(PlayingCard) playerDrawsCard;

  final void Function(String) gameOver;

  final void Function() dealerTurnCard;

  final void Function() isPlayerTurn;

  Hand player = Hand();
  Hand dealer = Hand();

  int playerScore = 0;
  int dealerScore = 0;

  double balance = 500; 
  double bet = 25;

  Future<void> startGame() async {
    player.hand.clear();
    dealer.hand.clear();

    playerScore = 0;
    dealerScore = 0;

    for (int i = 0; i < 2; i++) { // trage fiecare cate 2 carti
      await Future.delayed(const Duration(milliseconds: 600));
      player.drawCard(deck.last);
      deck.removeLast();
      playerScore = player.getTotal();
      playerDrawsCard(player.lastCard);

      await Future.delayed(const Duration(milliseconds: 600));
      dealer.drawCard(deck.last);
      deck.removeLast();
      dealerScore = dealer.getTotal();
      dealerDrawsCard(dealer.lastCard);
    }

    if (player.isBlackjack()) {
      balance += bet * 1.5;
      bet = 100;
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
    await Future.delayed(const Duration(milliseconds: 600));

    player.drawCard(deck.last);
    deck.removeLast();
    playerScore = player.getTotal();
    playerDrawsCard(player.lastCard);

    await Future.delayed(const Duration(milliseconds: 600));

    if (player.isBlackjack()) {
      balance += bet;
      bet = 100;
      gameOver('You won!');
      return;
    }

    if (player.getTotal() > 21) {
      balance -= bet;
      bet = 100;
      gameOver('Dealer won!');
      return;
    }

    isPlayerTurn();
  }

  Future<void> dealerTurn() async {

    await Future.delayed(const Duration(milliseconds: 600));
    dealerTurnCard();

    while (dealer.getTotal() < 17) {

      await Future.delayed(const Duration(milliseconds: 600));

      dealer.drawCard(deck.last);
      deck.removeLast();
      dealerScore = dealer.getTotal();
      dealerDrawsCard(dealer.lastCard);
    }

    await Future.delayed(const Duration(milliseconds: 600));

    if(dealerScore > 21) {
      gameOver('Player won!');
      balance += bet;
      bet = 100;
      return;
    }

    checkWinner();
  }

  void checkWinner() {
    if (dealerScore == playerScore) {
      bet = 100;
      gameOver('Push!');
    } else if (dealerScore > playerScore) {
      balance -= bet;
      bet = 100;
      gameOver('Dealer won!');
    } else {
      balance += bet;
      bet = 100;
      gameOver('You won!');
    }
  }

}
