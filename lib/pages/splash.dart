import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mathgame/pages/home_page.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  static final id = 'Splash';
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  _initTimer() {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacementNamed(context, HomePage.id);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Text(
            'Splash Screen ',
            style: TextStyle(fontSize: 25),
          ),
        ),
      ),
    );
  }
}
