import 'package:just_audio/just_audio.dart';

class GameAuidoPlayer {
  late AudioPlayer player;
  late AudioPlayer player1;

  GameAuidoPlayer() {
    player = AudioPlayer();
    player1 = AudioPlayer();
    player1.setAsset("assets/audio/bensound-slowmotion.mp3");
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

  void playMusic() {
    player1.play();
  }

  void stopMusic() {
    player1.stop();
  }
}
