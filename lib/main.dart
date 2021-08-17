import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<RectData> rects = [
    RectData(
        rect: Rect.fromLTWH(40, 60, 100, 100),
        color: Colors.red,
        colorName: "Red"),
    RectData(
        rect: Rect.fromLTWH(240, 240, 100, 100),
        color: Colors.yellow,
        colorName: "Yellow"),
    RectData(
        rect: Rect.fromLTWH(40, 240, 100, 100),
        color: Colors.green,
        colorName: "Green"),
    RectData(
        rect: Rect.fromLTWH(300, 500, 100, 100),
        color: Colors.purple,
        colorName: "Purple"),
    RectData(
        rect: Rect.fromLTWH(50, 540, 100, 100),
        color: Colors.white,
        colorName: "White"),
    RectData(
        rect: Rect.fromLTWH(100, 400, 100, 100),
        color: Colors.black,
        colorName: "Black"),
    RectData(
        rect: Rect.fromLTWH(200, 700, 100, 100),
        color: Colors.amber,
        colorName: "Amber"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: DefaultPainter(rects: rects),
        ),
      ),
    );
  }
}

class DefaultPainter extends CustomPainter {
  final List<RectData> rects;

  DefaultPainter({required this.rects});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawColor(Colors.cyan, BlendMode.darken);
    rects.forEach(
        (rect) => canvas.drawRect(rect.rect, Paint()..color = rect.color));
  }

  @override
  bool shouldRebuildSemantics(covariant CustomPainter oldDelegate) => false;

  @override
  bool? hitTest(Offset position) {
    String color = "Cyan";
    rects.forEach((element) {
      if (element.rect.contains(position)) {
        color = element.colorName;
      }
    });

    print("Tapped on $color");

    return false;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class RectData {
  final Rect rect;
  final Color color;
  final String colorName;

  RectData({
    required this.rect,
    required this.color,
    required this.colorName,
  });

  @override
  String toString() => "$colorName";
}
