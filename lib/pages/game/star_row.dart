import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRow extends StatelessWidget {
  final int stars;

  const StarRow({
    super.key,
    required this.stars,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final center = Offset(size.height * 0.15, size.height * 0.15);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.12, right: 8),
          child: Transform(
            transform: Matrix4.identity()
              ..scale(0.8)
              ..rotateZ(-3.14 * 15 / 180),
            origin: center,
            child: StarWidget(filled: stars > 0),
          ),
        ),
        StarWidget(filled: stars > 1),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.12, left: 8),
          child: Transform(
            transform: Matrix4.identity()
              ..scale(0.8)
              ..rotateZ(3.14 * 15 / 180),
            origin: center,
            child: StarWidget(filled: stars > 2),
          ),
        ),
      ],
    );
  }
}

class StarWidget extends StatelessWidget {
  final bool filled;

  const StarWidget({
    super.key,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SvgPicture.asset(
      "assets/images/${filled ? "" : "un"}filled_star_big.svg",
      width: size.height * 0.3,
      height: size.height * 0.3,
    );
  }
}
