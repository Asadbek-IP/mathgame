import 'package:flutter/material.dart';

class AnswerBoard extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const AnswerBoard(
    this.text, {
    super.key,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Board(
        borderRadius: 8,
        selected: selected,
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 48, fontFamily: "BubbleGumSans"),
        ),
      ),
    );
  }
}

class QuestionBoard extends StatelessWidget {
  final String text;

  const QuestionBoard(
    this.text, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Board(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 64, fontFamily: "BubbleGumSans"),
      ),
    );
  }
}

class Board extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final bool selected;

  const Board({
    super.key,
    required this.child,
    this.borderRadius = 16,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: selected ? const Color(0xFFFFEA00) : const Color(0xFF2F2F2F),
          width: 8,
        ),
        gradient: const RadialGradient(
          radius: 0.7,
          colors: [
            Color(0xFF4A8050),
            Color(0xFF2F5735),
          ],
        ),
      ),
      child: child,
    );
  }
}
