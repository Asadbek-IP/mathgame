import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';

class GameAuidoPlayer {
  late AudioPlayer player;

  GameAuidoPlayer() {
    player = AudioPlayer();
  }

  void clickSound() async {
    await player.setAsset("assets/audio/click.mp3");
    await player.play();
  }

  void correctSound() async {
    await player.setAsset("assets/audio/correct.mp3");
    await player.play();
  }

  void wrongSound() async {
    await player.setAsset("assets/audio/wrong.mp3");
    await player.play();
  }
}
