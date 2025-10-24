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
      gameOver('You won!');
      return;
    }

    if (player.getTotal() > 21) {
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
      return;
    }

    checkWinner();
  }

  void checkWinner() {
    if (dealerScore == playerScore) {
      gameOver('Push!');
    } else if (dealerScore > playerScore) {
      gameOver('Dealer won!');
    } else {
      gameOver('You won!');
    }
  }

}
