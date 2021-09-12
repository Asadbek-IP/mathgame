import 'package:flutter/material.dart';
import 'package:mathgame/pages/home_page.dart';
import 'package:mathgame/pages/splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: const Splash(),
      routes: {
        HomePage.id: (context) => HomePage(),
        Splash.id: (context) => Splash(),

      },
    );
  }
}
