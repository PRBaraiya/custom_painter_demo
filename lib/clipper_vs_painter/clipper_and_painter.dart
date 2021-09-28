import 'package:flutter/material.dart';

import '../widgets/button.dart';

part 'clipper.dart';
part 'painter.dart';

Path createPath(Size size, double timer) {
  final path = Path();

  path.moveTo(0, size.height * 0.8);

  var factor = 0.0;

  factor = 0.75 + (timer * 0.1);

  path.quadraticBezierTo(size.width * 0.25, size.height * factor,
      size.width * 0.5, size.height * 0.8);

  path.quadraticBezierTo(size.width * 0.75, size.height * (1.6 - factor),
      size.width, size.height * 0.8);

  path.lineTo(size.width, size.height);

  path.lineTo(0, size.height);
  path.close();

  return path;
}

Color mainWaveColor = Colors.orange;
Color subWaveColor = Colors.deepOrangeAccent.withOpacity(0.7);
Duration waveDuration = Duration(seconds: 2);
Curve waveCurve = Curves.easeInOut;

class ClipperAndPainter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              title: "Painter",
              page: PainterDemo(),
            ),
            Button(
              title: "Clipper",
              page: ClipperDemo(),
            )
          ],
        ),
      ),
    );
  }
}
