import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/widgets.dart';

class SemicircularCurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    Offset center = Offset(size.width / 2, size.height);

    // Draw a semicircular curve
    Paint paint = Paint()
      ..color = const Color.fromARGB(255, 187, 187, 187)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    Rect rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(rect, pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

double posx(DateTime rise, DateTime set, DateTime current, double width) {
  double x;
  if (current.millisecondsSinceEpoch > set.millisecondsSinceEpoch) {
    return width;
  } else if (current.millisecondsSinceEpoch < rise.millisecondsSinceEpoch) {
    return 0;
  }
  Duration duration = set.difference(rise);
  int diff = duration.inMinutes;
  Duration cduration = current.difference(rise);
  int cdiff = cduration.inMinutes;
  double ratio = cdiff / diff;
  x = width * ratio;
  return x;
}

double posy(double x) {
  double y=sqrt(100*x-x*x);
  return 50-y;
}


class sunPosition extends StatelessWidget {
  final DateTime sunrise;
  final DateTime sunset;
  final DateTime current;
  const sunPosition({super.key,
  required this.sunrise,
  required this.sunset,
  required this.current,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomPaint(
                size: Size(100, 50),
                painter: SemicircularCurvePainter(),
              ),
            ),
            Positioned(
                left: posx(
                  sunrise, 
                  sunset, 
                  current, 
                  100),
                top: posy(posx(
                  sunrise, 
                  sunset, 
                  current, 
                  100)),
                child: Container(
                  width: 15,
                  height: 15,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.orange,
                    boxShadow: [
                    BoxShadow(
                      color: Colors.orangeAccent,
                      spreadRadius: 8,
                      blurRadius: 20,
                    ),
                  ],
                  ),
                  
                ))
          ]),
        ),
      );
  }
}
