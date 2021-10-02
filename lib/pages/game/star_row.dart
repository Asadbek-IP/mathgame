import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarRow extends StatelessWidget {
  const StarRow({
    Key? key,
  }) : super(key: key);

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
            child: StarWidget(filled: true),
          ),
        ),
        StarWidget(filled: false),
        Padding(
          padding: EdgeInsets.only(top: size.height * 0.12, left: 8),
          child: Transform(
            transform: Matrix4.identity()
              ..scale(0.8)
              ..rotateZ(3.14 * 15 / 180),
            origin: center,
            child: StarWidget(filled: false),
          ),
        ),
      ],
    );
  }
}

class StarWidget extends StatelessWidget {
  final bool filled;

  const StarWidget({
    Key? key,
    required this.filled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SvgPicture.asset(
      "assets/images/" + (filled ? "" : "un") + "filled_star_big.svg",
      width: size.height * 0.3,
      height: size.height * 0.3,
    );
  }
}
