import 'package:flutter/material.dart';
import 'package:mathgame/pages/worlds/world_card.dart';

class WorldsPage extends StatelessWidget {
  const WorldsPage({Key? key}) : super(key: key);

  static const id = "worlds_page";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // double spaceBetweenWorlds = size.width/4
    return Scaffold(
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
                Image.asset(
                  "assets/images/select_world.png",
                  width: size.width * 0.45,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: WorldCard(
                                    image: "world1", unlocked: true, onTap: () {}, min: 0, max: 5),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: WorldCard(
                                    image: "world2", unlocked: false, onTap: () {}, min: 0, max: 5),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: WorldCard(
                                    image: "world3", unlocked: false, onTap: () {}, min: 0, max: 5),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: WorldCard(
                                    image: "world4", unlocked: false, onTap: () {}, min: 0, max: 5),
                              ),
                            ],
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
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          "assets/images/back_button.png",
                          width: 64,
                          height: 64,
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
    );
  }
}
