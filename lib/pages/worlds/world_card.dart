import 'package:flutter/material.dart';

class WorldCard extends StatelessWidget {
  final String image;
  final bool unlocked;
  final Function onTap;
  final int min;
  final int max;

  const WorldCard({
    Key? key,
    required this.image,
    required this.unlocked,
    required this.onTap,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(42),
              border: Border.all(color: Colors.white, width: 6),
              color: Colors.blueAccent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Stack(
                children: [
                  Image.asset(
                    "assets/images/$image.png",
                    fit: BoxFit.cover,
                  ),
                  if (unlocked)
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 32,
                      child: Container(
                        color: const Color(0xFF0098D0),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              const TextSpan(text: "NUMBERS "),
                              TextSpan(
                                text: "$min-$max",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                            style: const TextStyle(
                              fontFamily: "SmartKid",
                              fontSize: 22,
                              color: Color(0xFF003F56),
                            ),
                          ),
                        ),
                      ),
                    )
                  else
                    Positioned.fill(
                      child: Container(
                        color: Colors.white.withOpacity(0.3),
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (!unlocked)
            Image.asset(
              "assets/images/lock.png",
              width: 78,
              height: 93,
            ),
        ],
      ),
    );
  }
}
