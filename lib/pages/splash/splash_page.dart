import 'package:flutter/material.dart';
import 'package:mathgame/pages/home/home_page.dart';
import 'package:video_player/video_player.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset("assets/images/splash.mp4")
      ..initialize().then(
        (value) {
          _controller.addListener(() {
            if (_controller.value.isInitialized &&
                !_controller.value.isPlaying &&
                _controller.value.duration == _controller.value.position) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            }
          });
          _controller.play();
          setState(() {});
        },
      );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: VideoPlayer(_controller),
    );
  }
}
