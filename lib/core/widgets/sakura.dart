import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

// Flor de sakura, solo decoración, por eso el lector de pantalla la ignora
class Flor extends StatelessWidget {
  const Flor({super.key, this.tamano = 24, this.giro = 0});

  final double tamano;
  // Giro en radianes, para que las flores de un ramo no se vean iguales
  final double giro;

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: CustomPaint(size: Size.square(tamano), painter: _PintorFlor(giro)),
    );
  }
}

class _PintorFlor extends CustomPainter {
  const _PintorFlor(this.giro);

  final double giro;

  @override
  void paint(Canvas canvas, Size size) {
    final radio = size.width / 2;
    final claro = Paint()..color = Paleta.petalo;
    final oscuro = Paint()..color = Paleta.petaloOscuro;
    final centro = Paint()..color = Paleta.rosa;

    // Un pétalo apuntando hacia arriba, con la muesca en la punta
    final petalo = Path()
      ..moveTo(0, 0)
      ..cubicTo(
        -0.55 * radio,
        -0.25 * radio,
        -0.55 * radio,
        -0.85 * radio,
        -0.18 * radio,
        -radio,
      )
      ..quadraticBezierTo(0, -0.88 * radio, 0.18 * radio, -radio)
      ..cubicTo(0.55 * radio, -0.85 * radio, 0.55 * radio, -0.25 * radio, 0, 0)
      ..close();

    // Se dibuja desde el centro de la flor
    canvas.translate(radio, radio);
    canvas.rotate(giro);

    // Cinco pétalos, cada uno girado 72 grados (2π entre 5), en dos tonos
    for (var i = 0; i < 5; i++) {
      canvas.drawPath(petalo, i.isEven ? claro : oscuro);
      canvas.rotate(2 * pi / 5);
    }
    canvas.drawCircle(Offset.zero, radio * 0.14, centro);
  }

  // Es estática, solo se vuelve a dibujar si cambia el giro
  @override
  bool shouldRepaint(_PintorFlor anterior) => anterior.giro != giro;
}

// Ramito de tres flores de distinto tamaño
// escala 1 es el tamaño para las pantallas de vacío y de error
class RamoSakura extends StatelessWidget {
  const RamoSakura({super.key, this.escala = 1});

  final double escala;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100 * escala,
      height: 84 * escala,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 14 * escala,
            child: Flor(tamano: 56 * escala, giro: 0.2),
          ),
          Positioned(
            left: 52 * escala,
            top: 0,
            child: Flor(tamano: 36 * escala, giro: 1.0),
          ),
          Positioned(
            left: 60 * escala,
            top: 44 * escala,
            child: Flor(tamano: 28 * escala, giro: 0.6),
          ),
        ],
      ),
    );
  }
}
