import 'package:flutter/material.dart';
import 'package:weather_app/utilities/reusablefunctions.dart';
import 'package:weather_app/utilities/sunpos.dart';
import 'package:weather_icons/weather_icons.dart';

class sun extends StatefulWidget {
  final String sunrise;
  final String sunset;
  const sun({
    super.key,
    required this.sunrise,
    required this.sunset,
  });

  @override
  State<sun> createState() => _sunState();
}

class _sunState extends State<sun> {
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
        child: Row(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      WeatherIcons.sunrise,
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                    ),
                    Text(
                      "   Sunrise",
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.8)),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Text(
                      unixtotime(widget.sunrise),
                      style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500)
                      ),
              ],
            ),
            sunPosition(
              sunrise: unixtotime(widget.sunrise),
              sunset: unixtotime(widget.sunset),
              current: DateTime.now(),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Icon(
                      WeatherIcons.sunset,
                      color: const Color.fromARGB(255, 255, 255, 255)
                          .withOpacity(0.8),
                    ),
                    Text(
                      "   Sunset",
                      style: TextStyle(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 255, 255, 255)
                              .withOpacity(0.8)),
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Text(
                      unixtotime(widget.sunset),
                      style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500)
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
