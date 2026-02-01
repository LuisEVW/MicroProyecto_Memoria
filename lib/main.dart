import 'package:flutter/material.dart';
import 'package:microproyecto/PantallaPrincipal.dart';

void main() {
  runApp(const MicroProyecto());
}

class MicroProyecto extends StatelessWidget {
  const MicroProyecto({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Micro Proyecto Memoria',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const PantallaPrincipal(),
    );
  }
}