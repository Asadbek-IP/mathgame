import 'package:flutter/material.dart';
import 'package:mathgame/pages/worlds/worlds_page.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';

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
                Image.asset(
                  "assets/images/home_title.png",
                  width: size.width * 0.65,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClickSoundWidget(
                      onTap: () {},
                      child: Image.asset("assets/images/cup.png", width: 90, height: 90),
                    ),
                    const SizedBox(width: 64),
                    ClickSoundWidget(
                      onTap: () => setState(() => open = true),
                      child: Image.asset("assets/images/play.png", width: 90, height: 90),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClickSoundWidget(
                      onTap: () {},
                      child: Image.asset("assets/images/info.png", width: 56, height: 56),
                    ),
                    ClickSoundWidget(
                      onTap: () {},
                      child: Image.asset("assets/images/cart.png", width: 56, height: 56),
                    ),
                    ClickSoundWidget(
                      onTap: () {},
                      child: Image.asset("assets/images/star.png", width: 56, height: 56),
                    ),
                  ],
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
            right: open ? 0 : -150,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClickSoundWidget(
                  onTap: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 2))),
                  child: Image.asset("assets/images/easy.png", height: 64),
                ),
                const SizedBox(height: 8),
                ClickSoundWidget(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 2))),
                    child: Image.asset("assets/images/medium.png", height: 64)),
                const SizedBox(height: 8),
                ClickSoundWidget(
                    onTap: () => Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const WorldsPage(difficultyId: 3))),
                    child: Image.asset("assets/images/hard.png", height: 64)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
