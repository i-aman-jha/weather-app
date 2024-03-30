import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather_app/api.dart';
import 'package:weather_app/utilities/cardproperties.dart';
import 'package:weather_app/utilities/reusablefunctions.dart';
import 'package:weather_app/utilities/sun.dart';
import 'package:weather_app/utilities/weathercard.dart';
import 'package:weather_icons/weather_icons.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var Data;
  String url = '';
  String temp = '';
  String feelslike = '';
  String sunrise = '';
  String sunset = '';
  String dewPoint = '';
  String pressure = '';
  String humidity = '';
  String uvi = '';
  String visibility = '';
  String windSpeed = '';
  String windDirection = '';
  String description = '';
  String AQI = '';
  String clouds = '';
  String iconcode = '';
  String lat = '';
  String lon = '';

  Future<void> fetchData(String loc) async {
    try {
      String url =
          'https://api.openweathermap.org/data/2.5/weather?q=$loc&appid=4804f3e29bb9276ca2341e61e6f6aab1';
      var data = await getdata(url);
      var decodedData = jsonDecode(data);

      lat = decodedData['coord']['lat'].toString();
      lon = decodedData['coord']['lon'].toString();
      String url2 =
          'http://api.openweathermap.org/data/2.5/air_pollution/forecast?lat=$lat&lon=$lon&appid=4804f3e29bb9276ca2341e61e6f6aab1';
      var data2 = await getdata(url2);
      var decodedData2 = jsonDecode(data2);

      setState(() {
        description = capitalizeFirstLetter(
            decodedData['weather'][0]['description'].toString());
        iconcode = decodedData['weather'][0]['icon'].toString();
        temp = decodedData['main']['temp'].toString();
        temp = KtoC(temp);
        feelslike = decodedData['main']['feels_like'].toString();
        feelslike = KtoC(feelslike);
        pressure = decodedData['main']['pressure'].toString();
        humidity = decodedData['main']['humidity'].toString();
        visibility = decodedData['visibility'].toString();
        visibility=(int.parse(visibility)/1000).toString();
        windSpeed = decodedData['wind']['speed'].toString();
        windDirection = decodedData['wind']['deg'].toString();
        clouds = decodedData['clouds']['all'].toString();
        sunrise = decodedData['sys']['sunrise'].toString();
        sunset = decodedData['sys']['sunset'].toString();
        AQI = decodedData2['list'][0]['main']['aqi'].toString();
      });
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                const Color.fromARGB(255, 6, 54, 94),
                Colors.blue.shade700,
                Colors.blue.shade500,
                Colors.blue
              ])),
          child: Column(
            children: [
              AppBar(
                title: const Text(
                  "Weather",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    // fontWeight: FontWeight.w500,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
              ),
              WeatherCard(
                fetch: fetchData,
                temp: temp,
                feelslike: feelslike,
                description: description,
                clouds: clouds,
                iconcode: iconcode,
              ),
              Container(
                  margin: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          PCard(
                            property: " Wind",
                            icon: Icons.air,
                            aqi: false,
                            wind: true,
                            windDirection: windDirection,
                            value: "$windSpeed m/s",
                          ),
                          PCard(
                              property: " Visibility",
                              icon: Icons.visibility,
                              aqi: false,
                              wind: false,
                              windDirection: windDirection,
                              value: 
                              "$visibility km"),
                        ],
                      ),
                      Row(
                        children: [
                          PCard(
                            property: " Pressure",
                            icon: Icons.compress,
                            aqi: false,
                            wind: false,
                            windDirection: windDirection,
                            value: "$pressure hPa",
                          ),
                          PCard(
                            property: " Humidity",
                            icon: WeatherIcons.humidity,
                            aqi: false,
                            wind: false,
                            windDirection: windDirection,
                            value: "$humidity%",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          PCard(
                            property: " UV Index",
                            icon: Icons.sunny,
                            aqi: false,
                            wind: false,
                            windDirection: windDirection,
                            value: "9",
                          ),
                          PCard(
                            property: " Dew Point",
                            icon: Icons.water_drop,
                            aqi: false,
                            wind: false,
                            windDirection: windDirection,
                            value: "14 \u00B0C",
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          sun(
                            sunrise: sunrise,
                            sunset: sunset,),
                        ],
                      ),
                      Row(
                        children: [
                          PCard(
                            property: "AQI",
                            icon: Icons.masks,
                            aqi: true,
                            wind: false,
                            windDirection: windDirection,
                            value: (AQI == '1')
                                ? "Good"
                                : (AQI == '2')
                                    ? "Fair"
                                    : (AQI == '3')
                                        ? "Moderate"
                                        : (AQI == '4')
                                            ? "Poor"
                                            : (AQI == '5')
                                                ? "Very Poor"
                                                : "",
                          ),
                        ],
                      ),
                    ],
                  )),
              GestureDetector(
                onTap: () async {
                  await launchUrl(Uri.parse('https://openweathermap.org'));
                },
                child: const Text(
                  'Data provided by @openweather.org',
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
