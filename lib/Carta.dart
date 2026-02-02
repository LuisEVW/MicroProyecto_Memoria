import 'package:flutter/material.dart';

class Carta extends StatefulWidget {
  final int id;
  final String img;
  const Carta({super.key, required this.id, required this.img});

  @override
  State<Carta> createState() => _CartaState();
}

class _CartaState extends State<Carta> {
  @override
  bool visible = false;
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          visible = !visible;
        });
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Colors.deepOrange,
      ),
      child: visible
          ? Image.asset(widget.img)
          : SizedBox(width: 0, height: 0),
    );
  }
}
