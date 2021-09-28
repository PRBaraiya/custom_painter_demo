import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ArcText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = Size(MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomPaint(
              size: size,
              painter: GradientText(),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(),
              child: CustomPaint(
                size: size,
                painter: CircleText(
                  70,
                  "Here we go with arc text with radius of 70",
                  TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                  ),
                  initialAngle: -45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientText extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final offset = size.centerLeft(Offset.zero);

    final gradient = LinearGradient(colors: [Colors.blue, Colors.yellow])
        .createShader(offset & size);

    final builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    ));

    builder.pushStyle(ui.TextStyle(
      fontSize: 30,
      foreground: Paint()..shader = gradient,
    ));

    builder.addText("Gradient Text");

    final paragraph = builder.build();

    paragraph.layout(ui.ParagraphConstraints(
      width: size.width,
    ));

    canvas.drawParagraph(paragraph, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class CircleText extends CustomPainter {
  CircleText(this.radius, this.text, this.textStyle, {this.initialAngle = 0});

  final num radius;
  final String text;
  final double initialAngle;
  final TextStyle textStyle;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2 - radius);

    if (initialAngle != 0) {
      final d = 2 * radius * math.sin(initialAngle / 2);
      final rotationAngle = _calculateRotationAngle(0, initialAngle);
      canvas.rotate(rotationAngle);
      canvas.translate(d, 0);
    }

    double angle = initialAngle;
    for (int i = 0; i < text.length; i++) {
      angle = _drawLetter(canvas, text[i], angle);
    }
  }

  double _drawLetter(Canvas canvas, String letter, double prevAngle) {
    _textPainter.text = TextSpan(text: letter, style: textStyle);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );

    final double d = _textPainter.width;
    final double alpha = 2 * math.asin(d / (2 * radius));

    final newAngle = _calculateRotationAngle(prevAngle, alpha);
    canvas.rotate(newAngle);

    _textPainter.paint(canvas, Offset(0, -_textPainter.height));
    canvas.translate(d, 0);

    return alpha;
  }

  double _calculateRotationAngle(double prevAngle, double alpha) =>
      (alpha + prevAngle) / 2;

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
