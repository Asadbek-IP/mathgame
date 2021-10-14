import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/data/models/level.dart';
import 'package:mathgame/data/models/world.dart';
import 'package:mathgame/pages/game/bloc/game_bloc.dart';
import 'package:mathgame/pages/game/boards.dart';
import 'package:mathgame/pages/game/life_progressbar.dart';
import 'package:mathgame/pages/game/star_row.dart';
import 'package:mathgame/service_locator.dart';
import 'package:mathgame/util/constants.dart';
import 'package:mathgame/util/game_audio_player.dart';

class GamePage extends StatelessWidget {
  final World world;
  final Level level;

  const GamePage({Key? key, required this.world, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => GameBloc(sl(), world: world, level: level)..add(InitialEvent()),
      child: Scaffold(
        body: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state is CorrectAnswerState) {
              sl<GameAuidoPlayer>().correctSound();
            } else if (state is WrongAnswerState) {
              sl<GameAuidoPlayer>().wrongSound();
            } else if (state is NavigateBackState) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            print(state.toString());
            return Stack(
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
                      InkWell(
                        onTap: () => context.read<GameBloc>().add(PauseEvent()),
                        child: Image.asset(
                          "assets/images/pause.png",
                          height: 24,
                          width: 24,
                        ),
                      ),
                      const SizedBox(width: 8),
                      LifeProgressBar(state.life / lifeCount),
                      const SizedBox(width: 8),
                      Image.asset(
                        "assets/images/heart.png",
                        height: 24,
                        width: 24,
                      ),
                    ],
                  ),
                ),
                if (state.state == PlayState.play)
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.33,
                        height: size.height * 0.3,
                        child: QuestionBoard(state.question.question),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: state.question.answers
                            .map(
                              (answer) => SizedBox(
                                width: size.width * 0.15,
                                height: size.height * 0.2,
                                child: AnswerBoard("$answer",
                                    selected: false,
                                    onTap: () =>
                                        context.read<GameBloc>().add(AnswerSelectedEvent(answer))),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                Positioned(
                  right: 24,
                  bottom: 16,
                  left: 24,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "level".tr(args: [state.levelNumber.toString()]),
                        style: const TextStyle(
                            fontSize: 36, fontFamily: "BubbleGumSans", color: Color(0xFFFFC000)),
                      ),
                      const Spacer(),
                      Image.asset("assets/images/check.png", width: 32, height: 32),
                      const SizedBox(width: 4),
                      Text(
                        "${state.correctCount}/$questionPerLevel",
                        style: const TextStyle(
                          color: Color(0xFFFFC000),
                          fontFamily: "BubbleGumSans",
                          fontSize: 24,
                        ),
                      )
                    ],
                  ),
                ),
                if (state.state != PlayState.play)
                  Positioned.fill(
                    child: Container(color: Colors.black.withOpacity(0.8)),
                  ),
                if (state.state == PlayState.result || state.state == PlayState.pause)
                  Positioned.fill(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state.state != PlayState.pause) StarRow(stars: state.star),
                        Text(
                          "level".tr(args: [state.levelNumber.toString()]),
                          style: const TextStyle(
                              fontSize: 48, fontFamily: "SmartKid", color: Colors.white),
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
                              onPressed: () => Navigator.pop(context),
                              iconSize: 40,
                            ),
                            if (state.state == PlayState.pause) ...[
                              const SizedBox(width: 56),
                              IconButton(
                                icon: Image.asset("assets/images/play1.png"),
                                onPressed: () => context.read<GameBloc>().add(PlayEvent()),
                                iconSize: 72,
                              ),
                            ],
                            const SizedBox(width: 56),
                            IconButton(
                              icon: Image.asset("assets/images/reload.png"),
                              onPressed: () => context.read<GameBloc>().add(RetryEvent()),
                              iconSize: 40,
                            ),
                            if (state.star > 0) const SizedBox(width: 40),
                            if (state.state == PlayState.result)
                              Visibility(
                                visible: state.star > 0,
                                child: IconButton(
                                  icon: Image.asset("assets/images/right-arrow.png"),
                                  onPressed: () => context.read<GameBloc>().add(NextLevelEvent()),
                                  iconSize: 72,
                                ),
                                replacement: const SizedBox(width: 64),
                              ),
                          ],
                        ),
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
