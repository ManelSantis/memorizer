import 'dart:math';

class Game {
  List<String>? gameImg;

  final String hiddenCard = "assets/brain.png";
  List<String> valueCards = [
    "assets/circle.png",
    "assets/cloud.png",
    "assets/star.png",
    "assets/square.png",
    "assets/hole.png",
    "assets/light.png",
    "assets/moon.png",
    "assets/paint.png",
  ];

  List<String> cards = [];
  List<int> inserteds = [];

  final int cardCount = 16;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    for (var i = 0; i < cardCount; i++) {
      var value = Random().nextInt(8);
      while (inserteds.contains(value)){
        value = Random().nextInt(8);
      }
      var matches = 0;
      for (var j = 0; j < cards.length; j++){
        if (valueCards[value] == cards[j]) {
          matches++;
        }
      }

      cards.add(valueCards[value]);
      if (matches == 1) {
        inserteds.add(value);
      }

      matches = 0;
    }
   gameImg = List.generate(cardCount, (index) => hiddenCard);
  }

  void resetGame() {
    cards.clear();
    inserteds.clear();
    initGame();
  }
}

