import 'package:flutter/material.dart';
import 'package:mathgame/widgets/click_sound_widget.dart';

class LevelCard extends StatelessWidget {
  final int number;
  final bool unlocked;
  final int stars;
  final VoidCallback onTap;

  const LevelCard({
    Key? key,
    required this.number,
    required this.unlocked,
    required this.stars,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ClickSoundWidget(
      onTap: unlocked ? onTap : null,
      child: SizedBox(
        width: size.height * 0.25,
        height: size.height * 0.25 + 16,
        child: Opacity(
          opacity: unlocked ? 1 : 0.7,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 12, top: 12, left: 8),
                child: LevelBackground(
                  child: Text(
                    number.toString(),
                    style: const TextStyle(
                      fontSize: 32,
                      fontFamily: "WickedMouse",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              if (unlocked)
                Positioned(
                  bottom: 6,
                  left: 8,
                  right: 0,
                  child: LevelStars(stars),
                )
              else
                Image.asset(
                  "assets/images/locked.png",
                  width: 40,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class LevelStars extends StatelessWidget {
  final int stars;
  const LevelStars(this.stars, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const filledStar = "filled_star";
    const unfilledStar = "unfilled_star";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        3,
        (index) => Padding(
          padding: EdgeInsets.only(top: (index - 1).abs() * 6, right: 2),
          child: Image.asset(
            "assets/images/${stars > index ? filledStar : unfilledStar}.png",
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}

class LevelBackground extends StatelessWidget {
  final Widget child;

  const LevelBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFC77F4E), Color(0xFF7E3300)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Container(
          color: const Color(0xFFCA9F81),
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
