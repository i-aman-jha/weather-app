import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:weather_app/utilities/direction.dart';

class PCard extends StatelessWidget {
  final String property;
  final IconData icon;
  final bool aqi;
  final bool wind;
  final String windDirection;
  final String value;

  const PCard(
      {super.key,
      required this.property,
      required this.icon,
      required this.aqi,
      required this.wind,
      required this.windDirection,
      required this.value});

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  (aqi) ? MainAxisAlignment.center : MainAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8),
                ),
                Text(
                  property,
                  style: TextStyle(
                      fontSize: 20,
                      color:
                          const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
                ),
              ],
            ),
            (aqi)
                ? Column(
                    children: [
                      FAProgressBar(
                        currentValue: _getProgress(value),
                        maxValue: 500,
                        displayText: null,
                        backgroundColor: Colors.black.withOpacity(0.15),
                        progressColor: _getProgressColor(value),
                      ),
                      Text(
                        value,
                        style: TextStyle(
                            color: _getProgressColor(value),
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  )
                : (wind)?
                  Row(
                    children: [
                      WindDirectionWidget(angle: windDirection),
                      const SizedBox(width: 3,),
                      Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  ),
            
                    ],
                  )
                : Text(
                    value,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  ),
          ],
        ),
      ),
    );
  }
}

Color _getProgressColor(String value) {
  if (value == "Good") {
    return const Color.fromARGB(255, 62, 207, 255);
  } else if (value == "Fair") {
    return const Color.fromARGB(255, 120, 255, 125);
  } else if (value == "Moderate") {
    return Colors.yellow;
  } else if (value == "Poor") {
    return Colors.orange;
  } else if(value == "Very Poor"){
    return Colors.red;
  }
  else{
    return Colors.black.withOpacity(0.15);
  } 
}

double _getProgress(String value) {
  if (value == "Good") {
    return 50;
  } else if (value == "Fair") {
    return 120;
  } else if (value == "Moderate") {
    return 200;
  } else if (value == "Poor") {
    return 300;
  } else if(value == "Very Poor"){
    return 400;
  }
  else{
    return 0;
  } 
}
