import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mathgame/pages/levels/levels_page.dart';
import 'package:mathgame/pages/worlds/bloc/worlds_bloc.dart';
import 'package:mathgame/pages/worlds/world_card.dart';
import 'package:mathgame/service_locator.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';
import 'package:mathgame/widgets/title_text.dart';

class WorldsPage extends StatelessWidget {
  final int difficultyId;

  const WorldsPage({Key? key, required this.difficultyId}) : super(key: key);

  static const id = "worlds_page";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => sl<WorldsBloc>()..add(InitialWorldsEvent(difficultyId)),
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                "assets/images/background1.png",
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  TitleText(
                    "select_world".tr(),
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CustomScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: BlocBuilder<WorldsBloc, WorldsState>(
                              builder: (context, state) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: state.worlds
                                      .map(
                                        (world) => Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8),
                                          child: WorldCard(
                                              image: world.image,
                                              unlocked: world.unlocked,
                                              onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          LevelsPage(world: world),
                                                    ),
                                                  ),
                                              min: world.min,
                                              max: world.max),
                                        ),
                                      )
                                      .toList(),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
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
          ],
        ),
      ),
    );
  }
}
