import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  final int id;
  // final String img; // Descomentar si usas imagenes
  final bool visible;
  final VoidCallback presionar;

  const Carta({
    super.key, 
    required this.id, 
    // required this.img, 
    required this.visible, 
    required this.presionar
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Usamos GestureDetector o InkWell para mejor control
      onTap: presionar,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
          boxShadow: [BoxShadow(blurRadius: 2, color: Colors.black26)]
        ),
        child: Center(
          child: visible
            ? Text("$id", style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold))
            // Si tienes imagen, borra el Text de arriba y pon: Image.asset(img)
            
            : const Icon(Icons.question_mark, size: 40, color: Colors.white54), 
            // Esto es lo que se ve cuando está boca abajo
        ),
      ),
    );
  }
}
