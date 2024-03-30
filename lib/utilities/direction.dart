import 'dart:math' as math;
import 'package:flutter/material.dart';


class WindDirectionWidget extends StatelessWidget {
  final String angle; // Wind direction angle in degrees

  WindDirectionWidget({required this.angle});

  @override
  Widget build(BuildContext context) {
    double directionangle = double.tryParse(angle) ?? 0;
    return Transform.rotate(
      angle: (directionangle+180 - 90) * (math.pi / 180), // Convert angle to radians and adjust for icon orientation
      child: const Icon(
        Icons.arrow_forward,
        color: Colors.white,
      ),
    );
  }
}
