import 'package:flutter/material.dart';
import 'package:microproyecto/PantallaPrincipal.dart';

class Puntuaciones extends StatefulWidget {
  const Puntuaciones({super.key});
  @override
  State<Puntuaciones> createState() => _PuntuacionesState();
}

class _PuntuacionesState extends State<Puntuaciones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Mejor puntuación:',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              '[[[AQUÍ IRÁ LA MEJOR PUNTUACIÓN]]]',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PantallaPrincipal(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                ),
                child: Text(
                  "Volver a la Pantalla Principal",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
