import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  final int id;
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
    return GestureDetector( 
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
            ? Image.asset('imgs/icon$id.png')
            : const Icon(Icons.question_mark, size: 40, color: Colors.white54), 
        ),
      ),
    );
  }
}
