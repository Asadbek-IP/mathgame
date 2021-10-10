import 'package:flutter/material.dart';

class OutlinedText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final double? strokeWidth;
  final Color? strokeColor;

  const OutlinedText(
    this.text, {
    Key? key,
    this.style,
    this.strokeWidth,
    this.strokeColor,
  }) : super(key: key);

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
        ),
        Text(text, style: style),
      ],
    );
  }
}
