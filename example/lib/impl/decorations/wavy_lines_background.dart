import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedBackgroundDecoration extends StatelessWidget {
  final Widget child;
  final double rand = Random().nextDouble();

  AnimatedBackgroundDecoration({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Opacity(
              opacity: 0.3,
              child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomPaint(painter: BackgroundPainter(rand)))),
          child,
        ],
      );
}

class BackgroundPainter extends CustomPainter {
  final double value;

  BackgroundPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    drawForValue(
        canvas, size, value, Colors.cyan, size.height / 25, size.height / 10);
    drawForValue(canvas, size, value * 1.5 + 2231.2, Colors.pink,
        size.height / 20, size.height / 10);
    drawForValue(canvas, size, value * 2 + 512.2, Colors.yellow,
        size.height / 15, size.height / 10);
  }

  void drawForValue(Canvas canvas, Size size, double value, Color color,
      double height, double width) {
    return canvas.drawPoints(
        PointMode.lines,
        [
          for (int i = 0; i < 32; i++)
            Offset(
                size.width / 30.0 * i,
                size.height / 2 +
                    (cos(value * 100 + value + i / 50.0) +
                            cos(value * 50 + value + i / 15.0) +
                            cos(value * 300 + value + i / 8.0) +
                            (cos(value * -300 + value + i / 2.0) +
                                    cos(value * -305 + value + i / 3.0) +
                                    cos(value * 315 + value + i / 4.0)) /
                                3.0 +
                            cos(value * 205 + value + i / 15.0)) *
                        height *
                        3)
        ].convertToSolidLine(),
        Paint()
          ..blendMode = BlendMode.darken
          ..color = color
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke
          ..strokeWidth = width);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

extension SolidLinefeature on List<Offset> {
  List<Offset> convertToSolidLine() {
    final result = <Offset>[];
    result.add(first);
    for (var i = 1; i < length - 1; i++) {
      result.add(this[i]);
      result.add(this[i]);
    }
    result.add(last);
    return result;
  }
}