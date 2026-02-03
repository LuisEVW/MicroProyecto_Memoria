import 'dart:async';
import '../models/carta_juego.dart';

class GameLogic {
  // --- VARIABLES DE ESTADO ---
  List<GameCard> cards = [];
  
  // Lista temporal para guardar el índice de las 2 cartas que se están comparando
  List<int> openCardIndices = []; 
  
  int attempts = 0;   // Contador de intentos (Score)
  int timeElapsed = 0; // Tiempo en segundos
  Timer? _timer;      // Objeto interno para manejar el tiempo

  // --- INICIALIZACIÓN ---
  void initGame() {
    attempts = 0;
    timeElapsed = 0;
    openCardIndices = [];
    _timer?.cancel(); // Reiniciar timer si existía

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

  // --- LÓGICA DEL JUEGO ---

  // 1. Función para saber si se permite voltear una carta
  bool canFlip(int index) {
    // No permitir si ya hay 2 levantadas
    if (openCardIndices.length >= 2) return false;
    // No permitir si la carta ya está volteada o ya fue encontrada
    if (cards[index].isFlipped || cards[index].isMatched) return false;
    
    return true;
  }

  // 2. Función que ejecuta el volteo
  void flipCard(int index) {
    cards[index].isFlipped = true;
    openCardIndices.add(index);
  }

  // 3. Verificar si hay match (Esta función la llamará la UI después de voltear la segunda carta)
  bool checkMatch() {
    attempts++; // Sumamos un intento
    
    // Obtenemos los índices de las dos cartas levantadas
    int index1 = openCardIndices[0];
    int index2 = openCardIndices[1];

    // Comparamos las rutas de imagen (así sabemos si son la misma figura)
    if (cards[index1].caminoImagen == cards[index2].caminoImagen) {
      // MATCH!! Se quedan volteadas
      cards[index1].isMatched = true;
      cards[index2].isMatched = true;
      openCardIndices.clear(); // Limpiamos la lista temporal para el siguiente turno
      return true;
    } else {
      // NO MATCH. Retornamos false para que la UI sepa que debe esperar y voltearlas de nuevo
      return false;
    }
  }

  // 4. Resetear las cartas si no hubo match
  void resetTurn() {
    if (openCardIndices.length == 2) {
      int index1 = openCardIndices[0];
      int index2 = openCardIndices[1];
      cards[index1].isFlipped = false;
      cards[index2].isFlipped = false;
      openCardIndices.clear();
    }
  }
  
  // --- MANEJO DEL TIMER ---
  // Callback: Función que la UI nos pasa para ejecutar cada segundo (setState)
  void startTimer(Function onTick) {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeElapsed++;
      onTick(); // Llamamos a la UI para que se redibuje
    });
  }
  
  void stopTimer() {
    _timer?.cancel();
  }
}