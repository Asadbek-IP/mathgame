import 'dart:ui';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:launch_review/launch_review.dart';
import 'package:mathgame/pages/home/difficulty_text.dart';
import 'package:mathgame/pages/home/info_page.dart';
import 'package:mathgame/pages/worlds/worlds_page.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';
import 'package:mathgame/widgets/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var open = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/home_background.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 32,
            left: 32,
            right: 32,
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleText("game_title".tr()),
                const Spacer(flex: 1),
                Expanded(
                  flex: 7,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(flex: 1),
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(24),
                                child: Container(
                                  color: Colors.white30,
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                    child: const GamesGrid(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 1),
                      ClickSoundWidget(
                        onTap: () => setState(() => open = true),
                        child: Image.asset("assets/images/play.png", width: 90, height: 90),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          Positioned(
            right: 32,
            top: 16,
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClickSoundWidget(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const InfoPage())),
                  child: Image.asset("assets/images/info.png", width: 56, height: 56),
                ),
                ClickSoundWidget(
                  onTap: () => LaunchReview.launch(androidAppId: "com.example.mathgame"),
                  child: Image.asset("assets/images/star.png", width: 56, height: 56),
                ),
              ],
            ),
          ),
          if (open)
            Positioned.fill(
              child: GestureDetector(
                onTap: () => setState(() => open = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  color: Colors.white.withOpacity(open ? 0.4 : 0),
                ),
              ),
            ),
          AnimatedPositioned(
            top: 0,
            bottom: 0,
            right: open ? -8 : -150,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClickSoundWidget(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 1))),
                  child: DifficultyText("easy".tr(), backgroundColor: const Color(0xFF1FBD00)),
                ),
                const SizedBox(height: 8),
                ClickSoundWidget(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 2))),
                  child: DifficultyText("medium".tr(), backgroundColor: const Color(0xFFFFD800)),
                ),
                const SizedBox(height: 8),
                ClickSoundWidget(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 3))),
                  child: DifficultyText("hard".tr(), backgroundColor: const Color(0xFFCC0000)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GamesGrid extends StatelessWidget {
  const GamesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.extent(
      maxCrossAxisExtent: 96,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      children: [
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
        GameItem(),
      ],
    );
  }
}

class GameItem extends StatelessWidget {
  // final String image;
  // final String url;

  const GameItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () async => await canLaunch(url) ? await launch(url) : throw "Could not launch $url",
      child: Container(
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
