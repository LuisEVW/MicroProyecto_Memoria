import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  final int id;
  final String img; 
  final bool visible;
  final VoidCallback presionar;

  const Carta({
    super.key, 
    required this.id, 
    required this.img, 
    required this.visible, 
    required this.presionar
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: presionar,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12),
          boxShadow: const [BoxShadow(blurRadius: 2, color: Colors.black26)]
        ),
        child: Center(
          child: visible            
            // Usamos Padding para que no toque los bordes.
            ? Padding(
                padding: const EdgeInsets.all(4.0), // Margen interno
                child: Image.asset(img, fit: BoxFit.contain), 
              )
            // Si no está visible, mostramos el signo de interrogación
            : const Icon(Icons.question_mark, size: 40, color: Colors.white54), 
        ),
      ),
    );
  }
}