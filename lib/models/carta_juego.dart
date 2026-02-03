class GameCard {
  final int id;             // Identificador único para saber cuál carta específica es
  final String caminoImagen;   // La imagen que mostrará (ej: 'assets/leon.png')
  bool isFlipped;           // ¿Está volteada boca arriba?
  bool isMatched;           // ¿Ya encontraron su pareja?

  GameCard({
    required this.id,
    required this.caminoImagen,
    this.isFlipped = false,
    this.isMatched = false,
  });
}