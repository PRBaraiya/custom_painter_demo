import 'dart:ui';

import 'package:flutter/material.dart';

import 'ticket_painter.dart';

class PathExample extends StatelessWidget {
  const PathExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: PathPainter(),
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 100,
              width: 200,
              child: CustomPaint(
                painter: TicketPainter(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, size.height * 0.7);

    path.quadraticBezierTo(size.width * 0.25, size.height * 0.7,
        size.width * 0.5, size.height * 0.8);

    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9,
        size.width * 1.0, size.height * 0.8);

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.teal
        ..strokeWidth = 15,
    );

    final path2 = Path();

    path2.moveTo(0, size.height * 0.7);

    path2.lineTo(size.width * 0.25, size.height * 0.7);
    path2.lineTo(size.width * 0.5, size.height * 0.8);

    path2.lineTo(size.width * 0.75, size.height * 0.9);
    path2.lineTo(size.width * 1.0, size.height * 0.8);

    path2.lineTo(size.width, size.height);
    path2.lineTo(0, size.height);
    path2.close();

    canvas.drawPath(
      path2,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 2
        ..style = PaintingStyle.stroke,
    );

    canvas.drawPoints(
      PointMode.points,
      [
        Offset(0, size.height * 0.7),
        Offset(size.width * 0.25, size.height * 0.7),
        Offset(size.width * 0.5, size.height * 0.8),
        Offset(size.width * 0.75, size.height * 0.9),
        Offset(size.width * 1.0, size.height * 0.8),
      ],
      Paint()
        ..style = PaintingStyle.stroke
        ..color = Colors.black
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 10,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
