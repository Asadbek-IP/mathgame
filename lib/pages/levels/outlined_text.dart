import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? strokeWidth;
  final Color? strokeColor;

  const OutlinedText(
    this.text, {
    super.key,
    this.style,
    this.strokeWidth,
    this.strokeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: style?.copyWith(
            foreground: Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = strokeWidth ?? 0
              ..color = strokeColor ?? Colors.black
              ..strokeJoin = StrokeJoin.round,
          ),
          textAlign: TextAlign.center,
        ),
        Text(text, style: style, textAlign: TextAlign.center),
      ],
    );
  }
}
