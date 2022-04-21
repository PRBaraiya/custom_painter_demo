import 'package:flutter/material.dart';

class LiveDemo extends StatefulWidget {
  @override
  State<LiveDemo> createState() => _LiveDemoState();
}

class _LiveDemoState extends State<LiveDemo> {
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
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Move...
              },
              child: Text("Move"),
            ),
          ],
        ),
      ),
    );
  }
}

class DemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
