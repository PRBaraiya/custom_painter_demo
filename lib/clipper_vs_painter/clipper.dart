part of 'clipper_and_painter.dart';

class ClipperDemo extends StatefulWidget {
  const ClipperDemo({Key? key}) : super(key: key);

  @override
  _ClipperDemoState createState() => _ClipperDemoState();
}

class _ClipperDemoState extends State<ClipperDemo>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: waveDuration,
    )..addListener(() {
        if (_controller.isCompleted && _controller.value == 1) {
          _controller.reverse();
        } else if (_controller.isDismissed) {
          _controller.forward();
        }
      });

    _animation = CurvedAnimation(parent: _controller, curve: waveCurve);

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
                builder: (_, __) {
                  return ClipPath(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    clipper: BackgroundClipper(
                      value: _animation.value,
                    ),
                    child: Container(
                      height: size.height,
                      width: size.width,
                      color: subWaveColor,
                    ),
                  );
                },
              ),
              Center(
                child: Text("Clipper background..."),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundClipper extends CustomClipper<Path> {
  double value;

  BackgroundClipper({this.value = 0});

  @override
  Path getClip(Size size) => createPath(size, value);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) =>
      oldClipper is BackgroundClipper && value != oldClipper.value;
}
