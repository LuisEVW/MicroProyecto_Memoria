import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // NECESARIO PARA EL RECORD
import 'package:microproyecto/PantallaPrincipal.dart';
import 'package:microproyecto/Carta.dart';

class Memoria extends StatefulWidget {
  // Generamos los pares: 18 parejas (del 1 al 18)
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
  
  int score = 0;       // Intentos realizados
  int bestScore = 0;   // Mejor puntuación guardada
  
  // VARIABLES NUEVAS PARA TU LOGICA
  bool _estaProcesando = false; // El semáforo para evitar el 3er click
  Timer? _timer;
  int _segundosTranscurridos = 0;

  @override
  void initState() {
    super.initState();
    _cargarBestScore();
    _iniciarJuego();
  }

  void _iniciarJuego() {
    cartas = List<int>.from(widget.cartas);
    cartas.shuffle();
    visible = List<bool>.filled(cartas.length, false);
    matched = List<bool>.filled(cartas.length, false);
    seleccionados = [];
    score = 0;
    _segundosTranscurridos = 0;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _segundosTranscurridos++;
      });
    });
  }

  // Cargar el récord del celular
  Future<void> _cargarBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Si no hay record, ponemos 999 o 0 según prefieras
      bestScore = prefs.getInt('best_score') ?? 0;
    });
  }

  // Guardar si superó el récord (Menos intentos es mejor)
  Future<void> _guardarRecord() async {
    final prefs = await SharedPreferences.getInstance();
    // Si el record es 0 (primera vez) o si hizo menos intentos que el record actual
    if (bestScore == 0 || score < bestScore) {
      await prefs.setInt('best_score', score);
      setState(() {
        bestScore = score;
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // --- TABLERO (IZQUIERDA) ---
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: GridView.builder(
                itemCount: cartas.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  final id = cartas[index];
                  // Si no tienes las imagenes aún, usa iconos
                  // final imagen = 'imgs/icon$id.png'; 
                  
                  final isVisible = visible[index] || matched[index];
                  
                  return Carta(
                    id: id,
                    // img: imagen, // Descomentar cuando tengas imagenes
                    visible: isVisible,
                    presionar: () => _cartaPresionada(index),
                  );
                },
              ),
            ),
          ),
          
          const VerticalDivider(color: Colors.black, thickness: 2),
          
          // --- PANEL DE INFO (DERECHA) ---
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _infoBox("Tiempo", "$_segundosTranscurridos s"),
                const SizedBox(height: 20),
                _infoBox("Intentos", "$score"),
                 const SizedBox(height: 20),
                _infoBox("Récord", "$bestScore"),
                const SizedBox(height: 50),
                
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                  onPressed: () {
                    // Dialogo de salir
                     showDialog(
                       context: context,
                       builder: (context) => AlertDialog(
                         title: const Text("¿Salir?"),
                         content: const Text("Se perderá el progreso."),
                         actions: [
                           TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
                           TextButton(onPressed: () {
                             Navigator.pop(context); // Cierra dialogo
                             Navigator.pop(context); // Vuelve al main
                           }, child: const Text("Salir")),
                         ],
                       )
                     );
                  },
                  child: const Text("Regresar", style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBox(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(fontSize: 24, color: Colors.deepOrange)),
      ],
    );
  }

  // --- AQUÍ ESTÁ LA SOLUCIÓN AL BUG ---
  void _cartaPresionada(int index) {
    // 1. BLOQUEO: Si ya estamos procesando (esperando el delay), NO HACER NADA.
    if (_estaProcesando) return;
    
    // 2. Si la carta ya está visible o matcheada, ignorar.
    if (visible[index] || matched[index]) return;

    setState(() {
      visible[index] = true;
      seleccionados.add(index);
    });

    if (seleccionados.length == 2) {
      score++; // Aumentamos intentos
      
      final index1 = seleccionados[0];
      final index2 = seleccionados[1];

      if (cartas[index1] == cartas[index2]) {
        // MATCH!!
        setState(() {
          matched[index1] = true;
          matched[index2] = true;
          seleccionados.clear();
        });
        
        // Verificar si ganó (todos matched)
        if (matched.every((element) => element == true)) {
          _timer?.cancel();
          _guardarRecord();
          // Aquí podrías mostrar un dialogo de victoria
        }
        
      } else {
        // NO MATCH -> Activamos el bloqueo
        _estaProcesando = true; 

        Future.delayed(const Duration(milliseconds: 1000), () {
          // Validamos que el widget siga montado por seguridad
          if (mounted) {
            setState(() {
              visible[index1] = false;
              visible[index2] = false;
              seleccionados.clear();
              _estaProcesando = false; // Quitamos el bloqueo
            });
          }
        });
      }
    }
  }
}
