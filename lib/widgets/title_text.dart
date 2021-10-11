import 'package:flutter/material.dart';
import 'package:mathgame/pages/levels/outlined_text.dart';

class TitleText extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const TitleText(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _style = style ?? const TextStyle(fontSize: 64);
    return OutlinedText(
      text,
      style: _style.copyWith(
        fontFamily: "WickedMouse",
        color: const Color(0xDDF7A420),
      ),
      strokeWidth: 12,
      strokeColor: const Color(0xFFF80000),
    );
  }
}