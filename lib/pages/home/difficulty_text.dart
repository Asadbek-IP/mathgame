import 'package:flutter/material.dart';

class DifficultyText extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  const DifficultyText(
    this.text, {
    super.key,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        border: Border.all(width: 6, color: Colors.white),
      ),
      child: Text(
        text,
        style: const TextStyle(fontFamily: "SmartKid", fontSize: 28, color: Colors.white),
      ),
    );
  }
}
