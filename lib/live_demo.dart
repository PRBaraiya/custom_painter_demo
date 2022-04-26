import 'dart:async';

import 'package:flutter/material.dart';

class LiveDemo extends StatefulWidget {
  @override
  State<LiveDemo> createState() => _LiveDemoState();
}

class _LiveDemoState extends State<LiveDemo> {
  ValueNotifier<double> offset = ValueNotifier(0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(Duration(milliseconds: 50), (timer) {
    //   offset.value += 0.1;
    // });
  }

  @override
  void dispose() {
    // _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height - 100),
                painter: Grids(),
                foregroundPainter: CustomDemo(offset: offset),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDemo extends CustomPainter {
  final ValueNotifier offset;

  CustomDemo({required this.offset}) : super(repaint: offset);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 10;

    canvas.drawRect(Rect.fromLTWH(50, 50, 100, 100), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class Grids extends CustomPainter {
  static const width = 50.0;
  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; true; i++) {
      final point = width * (i + 1);
      if (point >= size.width) break;

      canvas.drawLine(Offset(point, 0), Offset(point, size.height),
          Paint()..color = Colors.red);
    }

    for (var i = 0; true; i++) {
      final point = width * i;
      if (point >= size.height) break;

      canvas.drawLine(Offset(0, point), Offset(size.width, point),
          Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
