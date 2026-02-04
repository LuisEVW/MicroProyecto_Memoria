import 'dart:async';
import '../models/carta_juego.dart';

class GameLogic {
  List<GameCard> cards = [];
  List<int> openCardIndices = [];
  int attempts = 0;
  int timeElapsed = 0;
  Timer? _timer;

  void initGame() {
    attempts = 0;
    timeElapsed = 0;
    openCardIndices = [];
    _timer?.cancel();

    List<String> images = [
      'assets/img1.png', 'assets/img2.png', 'assets/img3.png',
      'assets/img4.png', 'assets/img5.png', 'assets/img6.png',
      'assets/img7.png', 'assets/img8.png', 'assets/img9.png',
      'assets/img10.png', 'assets/img11.png', 'assets/img12.png',
      'assets/img13.png', 'assets/img14.png', 'assets/img15.png',
      'assets/img16.png', 'assets/img17.png', 'assets/img18.png',
    ];

    List<GameCard> tempCards = [];
    for (int i = 0; i < images.length; i++) {
      tempCards.add(GameCard(id: i * 2, caminoImagen: images[i]));
      tempCards.add(GameCard(id: i * 2 + 1, caminoImagen: images[i]));
    }

    tempCards.shuffle();
    cards = tempCards;
  }

  bool canFlip(int index) {
    if (openCardIndices.length >= 2) return false;
    if (cards[index].isFlipped || cards[index].isMatched) return false;
    return true;
  }

  void flipCard(int index) {
    cards[index].isFlipped = true;
    openCardIndices.add(index);
  }

  bool checkMatch() {
    attempts++;
    int index1 = openCardIndices[0];
    int index2 = openCardIndices[1];
    if (cards[index1].caminoImagen == cards[index2].caminoImagen) {
      cards[index1].isMatched = true;
      cards[index2].isMatched = true;
      openCardIndices.clear();
      return true;
    } else {
      return false;
    }
  }

  void resetTurn() {
    if (openCardIndices.length == 2) {
      int index1 = openCardIndices[0];
      int index2 = openCardIndices[1];
      cards[index1].isFlipped = false;
      cards[index2].isFlipped = false;
      openCardIndices.clear();
    }
  }

  void startTimer(Function onTick) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeElapsed++;
      onTick();
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }
}