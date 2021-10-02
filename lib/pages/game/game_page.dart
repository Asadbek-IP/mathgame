import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/pages/game/boards.dart';
import 'package:mathgame/pages/game/life_progressbar.dart';
import 'package:mathgame/pages/game/star_row.dart';

class GamePage extends StatelessWidget {
  final World world;
  final Level level;

  const GamePage({Key? key, required this.world, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_${world.image}.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.white.withOpacity(0.25),
            ),
          ),
          Positioned(
            left: 16,
            top: 16,
            child: Row(
              children: [
                Image.asset(
                  "assets/images/pause.png",
                  height: 32,
                  width: 32,
                ),
                const SizedBox(width: 8),
                LifeProgressBar(0.66),
                const SizedBox(width: 8),
                Image.asset(
                  "assets/images/heart.png",
                  height: 32,
                  width: 32,
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: size.width * 0.33,
                height: size.height * 0.3,
                child: QuestionBoard("17+13="),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: size.width * 0.15,
                    height: size.height * 0.2,
                    child: AnswerBoard("25", selected: true, onTap: () {}),
                  ),
                  SizedBox(
                    width: size.width * 0.15,
                    height: size.height * 0.2,
                    child: AnswerBoard("18", selected: false, onTap: () {}),
                  ),
                  SizedBox(
                    width: size.width * 0.15,
                    height: size.height * 0.2,
                    child: AnswerBoard("32", selected: false, onTap: () {}),
                  ),
                  SizedBox(
                    width: size.width * 0.15,
                    height: size.height * 0.2,
                    child: AnswerBoard("28", selected: false, onTap: () {}),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: 24,
            bottom: 16,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/check.png", width: 40, height: 40),
                const SizedBox(width: 4),
                Text(
                  "0/7",
                  style: TextStyle(
                    color: Color(0xFFFFC000),
                    fontFamily: "BubbleGumSans",
                    fontSize: 32,
                  ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Container(color: Colors.black.withOpacity(0.8)),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StarRow(),
                Text(
                  "LEVEL 7",
                  style: TextStyle(fontSize: 48, fontFamily: "SmartKid", color: Colors.white),
                ),
                const SizedBox(height: 16),
                Container(
                  width: size.width * 0.32,
                  height: 4,
                  color: Colors.white.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset("assets/images/home.png"),
                      onPressed: () {},
                      iconSize: 48,
                    ),
                    const SizedBox(width: 56),
                    IconButton(
                      icon: Image.asset("assets/images/reload.png"),
                      onPressed: () {},
                      iconSize: 48,
                    ),
                    const SizedBox(width: 40),
                    IconButton(
                      icon: Image.asset("assets/images/right-arrow.png"),
                      onPressed: () {},
                      iconSize: 64,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
