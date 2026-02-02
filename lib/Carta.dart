import 'package:flutter/material.dart';

class Carta extends StatelessWidget {
  final int id;
  final String img;
  final bool visible;
  final VoidCallback presionar;

  const Carta({super.key, required this.id, required this.img, required this.visible, required this.presionar});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: presionar,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.deepOrange,
      ),
      child: visible
        ? Image.asset(img) 
        : SizedBox(width: 0, height: 0),
    );
  }
}
