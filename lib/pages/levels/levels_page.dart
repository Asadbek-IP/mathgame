// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/pages/game/game_page.dart';
import 'package:mathgame/pages/levels/bloc/levels_bloc.dart';
import 'package:mathgame/pages/levels/level_card.dart';
import 'package:mathgame/pages/levels/outlined_text.dart';
import 'package:mathgame/service_locator.dart';
import 'package:mathgame/util/constants.dart';
import 'package:mathgame/util/extensions/list_extensions.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';
import 'package:mathgame/widgets/title_text.dart';

class LevelsPage extends StatelessWidget {
  final World world;

  const LevelsPage({super.key, required this.world});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LevelsBloc(sl(), world: world, pageController: PageController())..add(InitialEvent()),
      child: Scaffold(
        body: BlocBuilder<LevelsBloc, LevelsState>(
          builder: (context, state) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    "assets/images/background_${world.image}.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 12),
                  child: Column(
                    children: [
                      TitleText(
                        "select_level".tr(),
                        style: const TextStyle(fontSize: 36),
                      ),
                      Expanded(
                        child: PageView(
                          controller: state.controller,
                          physics: const BouncingScrollPhysics(),
                          children: state.levels
                              .chunk(levelEachWorld ~/ 2)
                              .map(
                                (chunkedLevels) => LevelsGrid(
                                  levels: chunkedLevels,
                                  onTap: (level) => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => GamePage(world: world, level: level),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: [
                            ClickSoundWidget(
                              onTap: () => Navigator.pop(context),
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
                        "${state.stars}/${state.maxStars}",
                        style: const TextStyle(
                            fontSize: 36, color: Colors.white, fontFamily: "SmartKid"),
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
                      PageIndicator(active: state.page == 0),
                      const SizedBox(width: 8),
                      PageIndicator(active: state.page == 1),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class LevelsGrid extends StatelessWidget {
  final List<Level> levels;
  final Function(Level) onTap;
  const LevelsGrid({super.key, required this.levels, required this.onTap});

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
              .map(
                (level) => LevelCard(
                    number: level.number,
                    unlocked: level.unlocked,
                    stars: level.stars,
                    onTap: () => onTap(level)),
              )
              .toList(),
        ),
      ],
    );
  }
}

class PageIndicator extends StatelessWidget {
  final bool active;

  const PageIndicator({super.key, required this.active});

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
