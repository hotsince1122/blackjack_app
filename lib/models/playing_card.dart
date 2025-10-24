import 'package:playing_cards/playing_cards.dart';

int getCardValueInBj(PlayingCard card) {
  switch(card.value) {
    case CardValue.ace: return 1;
    case CardValue.two: return 2;
    case CardValue.three: return 3;
    case CardValue.four: return 4;
    case CardValue.five: return 5;
    case CardValue.six: return 6;
    case CardValue.seven: return 7;
    case CardValue.eight: return 8;
    case CardValue.nine: return 9;
    case CardValue.ten: return 10;
    case CardValue.jack: return 10;
    case CardValue.queen: return 10;
    case CardValue.king: return 10;
    default: return 0;
  }
}

class Hand {
  List<PlayingCard> hand = [];

  PlayingCard get lastCard => hand.last;

  void drawCard(PlayingCard card) {
    hand.add(card);
  }

  int getTotal() {
    int sum = 0;
    int numOfAces = 0;

    for (var card in hand) {

      int value = getCardValueInBj(card);

      if (value > 10) {
        sum += 10;
        continue;
      }

      value != 1 ? sum += value : numOfAces++;
    }
    
    while(numOfAces != 0) {

      sum + 11 > 21 ? sum++ : sum += 11;

      numOfAces--;
    }
    
    return sum;
  }

  bool isBlackjack() {
    return getTotal() == 21;
  }
}
