// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// Custom Flutter F Logo
class FlutterFLogo extends StatelessWidget {
  final double size;
  final Color? color;

  const FlutterFLogo({
    super.key,
    this.size = 100,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final logoColor = color ?? Theme.of(context).primaryColor;

    return CustomPaint(
      size: Size(size, size),
      painter: FlutterFLogoPainter(color: logoColor),
    );
  }
}

class FlutterFLogoPainter extends CustomPainter {
  final Color color;

  FlutterFLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final width = size.width;
    final height = size.height;

    // Vertical stem (left side of F)
    final stem = Path()
      ..moveTo(width * 0.15, height * 0.0)
      ..lineTo(width * 0.35, height * 0.0)
      ..lineTo(width * 0.32, height * 1.0)
      ..lineTo(width * 0.12, height * 1.0)
      ..close();

    paint.color = color;
    canvas.drawPath(stem, paint);

    // Top horizontal bar of F
    final topBar = Path()
      ..moveTo(width * 0.35, height * 0.0)
      ..lineTo(width * 0.95, height * 0.0)
      ..lineTo(width * 0.92, height * 0.15)
      ..lineTo(width * 0.32, height * 0.15)
      ..close();

    paint.color = color.withOpacity(0.85);
    canvas.drawPath(topBar, paint);

    // Middle horizontal bar of F
    final midBar = Path()
      ..moveTo(width * 0.35, height * 0.4)
      ..lineTo(width * 0.8, height * 0.4)
      ..lineTo(width * 0.77, height * 0.55)
      ..lineTo(width * 0.32, height * 0.55)
      ..close();

    paint.color = color.withOpacity(0.7);
    canvas.drawPath(midBar, paint);
  }

  @override
  bool shouldRepaint(FlutterFLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}
