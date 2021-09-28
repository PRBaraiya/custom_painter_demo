import 'package:flutter/material.dart';

import 'widgets/button.dart';

class ClipperAndPainter extends StatelessWidget {
  const ClipperAndPainter({Key? key}) : super(key: key);

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
            ),
          ],
        ),
      ),
    );
  }
}

class ClipperDemo extends StatelessWidget {
  const ClipperDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: SafeArea(
            child: Text("Hey there"),
          ),
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: PerformanceOverlay.allEnabled(),
          ),
        ),
      ],
    );
  }
}

class PainterDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

class PathAnimator extends ChangeNotifier {
  late final Path path;

  PathAnimator() {
    path = create();
  }

  Path create() {
    final path = Path();

    path.moveTo(0, 0);
    path.close();

    return path;
  }
}
