import 'package:flutter/material.dart';
import 'package:mathgame/service_locator.dart';
import 'package:mathgame/util/game_audio_player.dart';

class ClickSoundWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;

  const ClickSoundWidget({Key? key, required this.onTap, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap == null
          ? null
          : () {
              sl<GameAuidoPlayer>().clickSound();
              onTap?.call();
            },
      child: child,
    );
  }
}
