import 'package:flutter/material.dart';
import 'package:mathgame/pages/levels/outlined_text.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TitleText(this.text, {super.key, this.style});

  @override
  Widget build(BuildContext context) {
    final style2 = style ?? const TextStyle(fontSize: 48);
    return OutlinedText(
      text,
      style: style2.copyWith(
        fontFamily: "WickedMouse",
        color: Colors.white,
      ),
      strokeWidth: 12,
      strokeColor: const Color(0xFFF80000),
    );
  }
}
