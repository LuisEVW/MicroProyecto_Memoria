class GameCard {
  final int id;
  final String caminoImagen;
  bool isFlipped;
  bool isMatched;

  GameCard({
    required this.id,
    required this.caminoImagen,
    this.isFlipped = false,
    this.isMatched = false,
  });
}