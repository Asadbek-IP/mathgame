import 'package:flutter/material.dart';

class AnswerBoard extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const AnswerBoard(
    this.text, {
    Key? key,
    required this.selected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Board(
        child: Text(
          text,
          style: const TextStyle(color: Colors.white, fontSize: 48, fontFamily: "BubbleGumSans"),
        ),
        borderRadius: 8,
        selected: selected,
      ),
    );
  }
}

class QuestionBoard extends StatelessWidget {
  final String text;

  const QuestionBoard(
    this.text, {
    Key? key,
  }) : super(key: key);

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
    Key? key,
    required this.child,
    this.borderRadius = 16,
    this.selected = false,
  }) : super(key: key);

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
