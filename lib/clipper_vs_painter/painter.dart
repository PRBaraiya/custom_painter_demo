part of 'clipper_and_painter.dart';

class PainterDemo extends StatefulWidget {
  @override
  _PainterDemoState createState() => _PainterDemoState();
}

class _PainterDemoState extends State<PainterDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: waveDuration)
      ..addListener(() {
        if (_controller.isCompleted && _controller.value == 1) {
          _controller.reverse();
        } else if (_controller.isDismissed) {
          _controller.forward();
        }
      });

    _animation = CurvedAnimation(
      parent: _controller,
      curve: waveCurve,
    );
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox.fromSize(
          size: size,
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (_, __) => CustomPaint(
                  size: size,
                  painter: BackgroundPainter(
                    value: _animation.value,
                  ),
                ),
              ),
              Center(
                child: Text("Painter background..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  double value;

  BackgroundPainter({this.value = 0});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      createPath(size, value),
      Paint()
        ..color = mainWaveColor
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) =>
      oldDelegate is BackgroundPainter && value != oldDelegate.value;
}
