import 'package:flutter/material.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/pages/levels/level_card.dart';
import 'package:mathgame/pages/levels/outlined_text.dart';
import 'package:mathgame/util/constants.dart';
import 'package:mathgame/util/extensions/list_extensions.dart';

class LevelsPage extends StatefulWidget {
  final World world;

  const LevelsPage({Key? key, required this.world}) : super(key: key);

  static const id = "levels_page";

  @override
  State<LevelsPage> createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  late final PageController pageController;
  var selectedIndex = 0;

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        selectedIndex = pageController.page?.toInt() ?? 0;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var levels = List.generate(
      20,
      (index) =>
          Level(id: 1, number: index + 1, stars: index % 3, unlocked: index < 2, timedLevel: false),
    );
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background_${widget.world.image}.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/select_level.png",
                  width: size.width * 0.4,
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    physics: const BouncingScrollPhysics(),
                    children: levels
                        .chunk(levelEachWorld ~/ 2)
                        .map(
                          (chunkedLevels) => LevelsGrid(levels: chunkedLevels, onTap: (level) {}),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          "assets/images/back_button.png",
                          width: 56,
                          height: 56,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 20,
            top: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                OutlinedText(
                  "${widget.world.stars}/60",
                  style: const TextStyle(fontSize: 36, color: Colors.white, fontFamily: "SmartKid"),
                  strokeWidth: 4,
                  strokeColor: Colors.orange,
                ),
                const SizedBox(width: 8),
                Image.asset("assets/images/filled_star.png", width: 40, height: 40),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 0,
            left: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PageIndicator(active: selectedIndex == 0),
                const SizedBox(width: 8),
                PageIndicator(active: selectedIndex == 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LevelsGrid extends StatelessWidget {
  final List<Level> levels;
  final Function(Level) onTap;
  const LevelsGrid({Key? key, required this.levels, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: levels
              .sublist(0, 5)
              .map(
                (level) => LevelCard(
                    number: level.number,
                    unlocked: level.unlocked,
                    stars: level.stars,
                    onTap: () => onTap(level)),
              )
              .toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: levels
              .sublist(5, 10)
              .map((e) =>
                  LevelCard(number: e.number, unlocked: e.unlocked, stars: e.stars, onTap: () {}))
              .toList(),
        ),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool active;

  const PageIndicator({Key? key, required this.active}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 16,
      height: 16,
      decoration: BoxDecoration(
        color: active ? const Color(0xFFC18E6B) : Colors.transparent,
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
