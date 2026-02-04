import 'package:flutter/material.dart';
import 'package:microproyecto/PantallaPrincipal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Puntuaciones extends StatefulWidget {
  const Puntuaciones({super.key});
  @override
  State<Puntuaciones> createState() => _PuntuacionesState();
}

class _PuntuacionesState extends State<Puntuaciones> {
  int bestScore = 0;
  int bestPoints = 0;

  @override
  void initState() {
    super.initState();
    _cargarBestScores();
  }

  Future<void> _cargarBestScores() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      bestScore = prefs.getInt('best_score') ?? 0;
      bestPoints = prefs.getInt('best_points') ?? 0;
    });
  }
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
            Column(
              children: [
                Text(
                  bestScore > 0 ? 'Menores intentos: $bestScore' : 'Menores intentos: -',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  bestPoints > 0 ? 'Mejor puntuación: $bestPoints pts' : 'Mejor puntuación: -',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ],
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
            const SizedBox(height: 16),
            SizedBox(
              width: 300,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Confirmar'),
                      content: const Text('¿Borrar ambos récords? Esta acción no se puede deshacer.'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancelar')),
                        TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Borrar')),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('best_score');
                    await prefs.remove('best_points');
                    setState(() {
                      bestScore = 0;
                      bestPoints = 0;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Récords borrados'), backgroundColor: Colors.deepOrange));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[700],
                ),
                child: const Text('Borrar récords', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
