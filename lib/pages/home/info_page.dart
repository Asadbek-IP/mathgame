// ignore: implementation_imports
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:mathgame/util/constants.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';
import 'package:mathgame/widgets/title_text.dart';
import 'package:url_launcher/url_launcher.dart';

const _url = "https://www.google.com";

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/background1.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TitleText(
                    "information".tr(),
                    style: const TextStyle(fontSize: 38),
                  ),
                  const Spacer(),
                  const DifficultyInfoText(
                    "easy_info",
                    operations: "$addSign $subtractSign",
                    upto: 20,
                    color: Color(0xFF1FBD00),
                  ),
                  const DifficultyInfoText(
                    "medium_info",
                    operations: "$addSign $subtractSign",
                    upto: 100,
                    color: Color(0xFFFFFF00),
                  ),
                  const DifficultyInfoText(
                    "hard_info",
                    operations: "$addSign $subtractSign $multiplySign $divideSign",
                    upto: 100,
                    color: Color(0xFFCC0000),
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ClickSoundWidget(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          "assets/images/back_button.png",
                          width: 56,
                          height: 56,
                        ),
                      ),
                      GestureDetector(
                        onTap: () async => await canLaunch(_url)
                            ? await launch(_url)
                            : throw "Could not launch $_url",
                        child: const Text(
                          _url,
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DifficultyInfoText extends StatelessWidget {
  final String infoKey;
  final String operations;
  final int upto;
  final Color color;

  const DifficultyInfoText(
    this.infoKey, {
    Key? key,
    required this.operations,
    required this.upto,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      infoKey.tr(args: [operations, upto.toString()]),
      style: TextStyle(
        fontSize: 36,
        color: color,
        fontFamily: "BubbleGumSans",
      ),
    );
  }
}
