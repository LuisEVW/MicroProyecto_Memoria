import 'package:flutter/material.dart';
import 'package:microproyecto/PantallaPrincipal.dart';
import 'package:microproyecto/Carta.dart';

class Memoria extends StatefulWidget {
  final List<int> cartas = [
    1,
    2,
    3,
    4,
    5,
    6,
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    13,
    14,
    15,
    16,
    17,
    18,
  ];
  Memoria({super.key});
  @override
  State<Memoria> createState() => _MemoriaState();
}

class _MemoriaState extends State<Memoria> {
  late List<int> cartas;

  @override
  void initState() {
    super.initState();
    cartas = List<int>.from(widget.cartas);
    cartas.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 600,
              height: 600,
              child: GridView.builder(
                itemCount: cartas.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final id = cartas[index];
                  final imagen = 'imgs/icon$id.png';
                  return Carta(id: id, img: imagen);
                },
              ),
            ),
            VerticalDivider(color: Colors.black, thickness: 2),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Text(
                      'Puntuación:',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: Text(
                      '0',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 250, width: 200),
                  SizedBox(
                    height: 100,
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                "¿Estás seguro de que quieres regresar a la pantalla principal?",
                              ),
                              content: Text(
                                "Se perderá todo el progreso conseguido en la partida actual",
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Cancelar"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PantallaPrincipal(),
                                      ),
                                    );
                                  },
                                  child: Text("Aceptar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepOrange,
                      ),
                      child: Text(
                        "Regresar",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
