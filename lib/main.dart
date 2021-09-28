import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathgame/pages/home_page.dart';
import 'package:mathgame/pages/splash.dart';
import 'package:mathgame/pages/worlds/worlds_page.dart';
import 'package:mathgame/service_locator.dart';

void main() {
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return MaterialApp(
      home: HomePage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        Splash.id: (context) => Splash(),
      },
    );
  }
}
