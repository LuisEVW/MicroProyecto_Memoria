import 'package:flutter/material.dart';
import 'package:microproyecto/PantallaPrincipal.dart';
import 'package:microproyecto/Carta.dart';

class Memoria extends StatefulWidget {
  final List<int> cartas = List<int>.generate(36, (i) => (i % 18) + 1);
  Memoria({super.key});
  @override
  State<Memoria> createState() => _MemoriaState();
}

class _MemoriaState extends State<Memoria> {
  late List<int> cartas;
  late List<bool> visible;
  late List<bool> matched;
  List<int> seleccionados = [];
  int score = 0;

  @override
  void initState() {
    super.initState();
    cartas = List<int>.from(widget.cartas);
    cartas.shuffle();
    visible = List<bool>.filled(cartas.length, false);
    matched = List<bool>.filled(cartas.length, false);
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
                  final isVisible = visible[index] || matched[index];
                  return Carta(
                    id: id,
                    img: imagen,
                    visible: isVisible,
                    presionar: () => _cartaPresionada(index),
                  );
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
                      '$score',
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

  void _cartaPresionada(int index) {
    if (matched[index]) return;
    if (visible[index]) return;

    setState(() {
      visible[index] = true;
      seleccionados.add(index);
    });

    if (seleccionados.length == 2) {
      final num1 = seleccionados[0];
      final num2 = seleccionados[1];
      if (cartas[num1] == cartas[num2]) {
        setState(() {
          matched[num1] = true;
          matched[num2] = true;
          seleccionados.clear();
        });
      } else {
        // Aquí ocurre un error si intentas agarrar una tercera o cuarta carta antes de que se acabe el temporizador, que hace que se quede marcada. Hay que impedir que el jugador toque una tercera carta mientras se acaba el temporizador (que es más intuitivo, pero no sé si más difícil de implementar) o hacer que cuando intente tocar una tercera carta las dos anteriores desaparezcan si no son iguales
        Future.delayed(Duration(milliseconds: 500), () {
          setState(() {
            visible[num1] = false;
            visible[num2] = false;
            seleccionados.clear();
          });
        });
      }
    }
  }
}
