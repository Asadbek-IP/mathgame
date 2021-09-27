import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/pages/home_page.dart';
import 'package:mathgame/pages/levels/levels_page.dart';
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
      home: LevelsPage(
          world: World(
              id: 1,
              difficulty: 1,
              image: "world1",
              unlocked: true,
              stars: 21,
              allowedOperations: [],
              min: 1,
              max: 5)),
      routes: {
        HomePage.id: (context) => HomePage(),
        Splash.id: (context) => Splash(),
      },
    );
  }
}
