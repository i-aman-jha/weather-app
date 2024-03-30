import 'package:flutter/material.dart';
import 'package:weather_app/pages/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(textTheme: Typography(platform: TargetPlatform.android).white,appBarTheme: AppBarTheme(backgroundColor: Colors.transparent))
    );
  }
}
