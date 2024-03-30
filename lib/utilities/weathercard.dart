import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:weather_app/utilities/reusablefunctions.dart';
import 'package:weather_app/utilities/search.dart';

class WeatherCard extends StatefulWidget {
  final Function(String) fetch;
  final String temp;
  final String feelslike;
  final String description;
  final String clouds;
  final String iconcode;
  const WeatherCard({
    super.key,
    required this.fetch,
    required this.temp,
    required this.feelslike,
    required this.description,
    required this.clouds,
    required this.iconcode,
  });

  @override
  State<WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<WeatherCard> {
  String loc = "";
  void getloc(String location) {
    setState(() {
      (location.isNotEmpty)?loc = location:loc="Ranchi";
      // print(loc);
    });
  }

  void fetchData(String loc) {
    widget.fetch(loc);
  }

  @override
  void initState() {
    setState(() {
      loc="Ranchi";
      fetchData(loc);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        search(getloc: getloc, fetchData: fetchData),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_pin,
                    color: Colors.white,
                  ),
                  Text(
                    capitalizeFirstLetter(loc),
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
              SizedBox(
                  height: 200,
                  width: 200,
                  child: (widget.iconcode.isNotEmpty)?Image.network(
                    'https://openweathermap.org/img/wn/${widget.iconcode}@4x.png',
                    fit: BoxFit.cover, 
                  ):
                  Center(child: LoadingAnimationWidget.fourRotatingDots(color: Color.fromARGB(255, 0, 255, 221), size: 40))
                  ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.temp,
                        style: TextStyle(fontSize: 80),
                      ),
                      const Text(
                        "\u00B0C",
                        style: TextStyle(
                          fontSize: 30,
                          fontFeatures: [FontFeature.superscripts()],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Feels like ${widget.feelslike} \u00B0C",
                    style: const TextStyle(fontSize: 19),
                  ),
                  Text(
                    widget.description,
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(
                    "${widget.clouds}% Clouds",
                    style: const TextStyle(fontSize: 17),
                  ),
                  const SizedBox(height: 10),
                  // Container(
                  //   alignment: Alignment.center,
                  //   padding: const EdgeInsets.all(5),
                  //   width: MediaQuery.of(context).size.width * 0.3,
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.4),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: const Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.masks),
                  //       Text(
                  //         "AQI $AQI",
                  //         style: TextStyle(
                  //           fontSize: 19,
                  //           fontWeight: FontWeight.w500,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
