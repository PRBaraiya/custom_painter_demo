import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final double _imageHeight = 121;
final double _imageWidth = 256;

class CanvasExample extends StatefulWidget {
  @override
  _CanvasExampleState createState() => _CanvasExampleState();
}

class _CanvasExampleState extends State<CanvasExample> {
  ui.Image? image;

  @override
  void initState() {
    super.initState();

    loadImage();
  }

  void loadImage() {
    rootBundle.load("assets/flutter_banner.png").then((value) async {
      final codec = await ui.instantiateImageCodec(
        value.buffer.asUint8List(),
        targetHeight: _imageHeight.toInt(),
        targetWidth: _imageWidth.toInt(),
      );
      final result = (await codec.getNextFrame()).image;
      codec.dispose();
      if (mounted) setState(() => image = result);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: CanvasPainter(image: image),
          ),
        ],
      ),
    );
  }
}

class CanvasPainter extends CustomPainter {
  ui.Image? image;

  CanvasPainter({
    this.image,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draws circle
    canvas.drawCircle(
      Offset(80, 100),
      60,
      Paint()..color = Colors.red,
    );

    drawText(
      canvas: canvas,
      size: size,
      text: "Circle",
      offset: Offset(55, 90),
      color: Colors.white,
    );

    // Draws Rectangle.
    canvas.drawRect(
      Rect.fromLTWH(200, 50, 150, 100),
      Paint()..color = Colors.greenAccent,
    );

    drawText(
      canvas: canvas,
      size: size,
      text: "Rectangle",
      offset: Offset(230, 90),
    );

    final roundedRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(50, 200, 150, 100),
      Radius.circular(10),
    );

    canvas.drawShadow(
      Path()..addRRect(roundedRect),
      Colors.black,
      10,
      true,
    );

    // Draws rounded rectangle.
    canvas.drawRRect(
      roundedRect,
      Paint()..color = Colors.deepOrangeAccent,
    );

    drawText(
      canvas: canvas,
      size: size,
      text: "Rounded\nRectangle",
      offset: Offset(80, 225),
      color: Colors.white,
    );

    // Difference of two rounded rectangle.
    canvas.drawDRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(230, 200, 150, 100),
        Radius.circular(10),
      ),
      RRect.fromRectAndRadius(
        Rect.fromLTWH(235, 205, 140, 90),
        Radius.circular(10),
      ),
      Paint()
        ..color = Colors.cyan
        ..style = PaintingStyle.fill,
    );

    // Draws arc.
    canvas.drawArc(
      Rect.fromLTWH(-10, 350, 100, 100),
      -pi / 2,
      pi / 2,
      false,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    );

    if (image != null) {
      final offset = Offset(150, 320);

      canvas.drawImage(image!, offset, Paint());
    }

    // Add two different ways to draw text in PPT.
    final paragraphBuilder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textDirection: TextDirection.ltr,
    ));

    // Always call this first
    paragraphBuilder.pushStyle(ui.TextStyle(fontSize: 30, color: Colors.black));
    paragraphBuilder.addText("This is Paragraph.");

    final paragraph = paragraphBuilder.build(); // Returns paragraph.

    // Must be called before calling drawParagraph.
    paragraph.layout(ui.ParagraphConstraints(width: 300));

    canvas.drawParagraph(paragraph, Offset(50, 500));
  }

  void drawText({
    required Canvas canvas,
    required Size size,
    required String text,
    Color color = Colors.black,
    Offset offset = Offset.zero,
    double minWidth = 0,
    double? maxWidth,
    TextStyle? style,
  }) {
    // Provided by flutter library.
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: style ??
            TextStyle(
              color: color,
              fontSize: 20,
            ),
      ),
      textDirection: TextDirection.ltr, // This is important to display text.
    );

    // This is an important step to draw Paragraph.
    textPainter.layout(
      minWidth: minWidth,
      maxWidth: maxWidth ?? size.width,
    );

    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is CanvasPainter && image != oldDelegate.image;
}
