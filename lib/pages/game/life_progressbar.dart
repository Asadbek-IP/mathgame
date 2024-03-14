import 'package:flutter/material.dart';

class LifeProgressBar extends StatelessWidget {
  final double progress;

  const LifeProgressBar(
    this.progress, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 24,
      child: CustomPaint(painter: LifeProgressBarPainter(progress)),
    );
  }
}

class LifeProgressBarPainter extends CustomPainter {
  final double progress;
  static const borderWidth = 2.0;

  LifeProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final greenPaint = Paint()..color = const Color(0xFF00BA00);
    final outerRRect = RRect.fromLTRBR(
      0,
      0,
      size.width,
      size.height,
      Radius.circular(size.height / 2),
    );
    final innerRRect = RRect.fromLTRBR(
      borderWidth,
      borderWidth,
      size.width - borderWidth,
      size.height - borderWidth,
      Radius.circular(size.height / 2),
    );
    canvas.drawPath(
      Path.combine(
        PathOperation.intersect,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width * progress, size.height)),
        Path()..addRRect(outerRRect),
      ),
      greenPaint,
    );
    canvas.drawDRRect(
      outerRRect,
      innerRRect,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
