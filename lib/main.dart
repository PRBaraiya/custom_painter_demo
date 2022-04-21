import 'package:custom_painter/arc_text.dart';
import 'package:custom_painter/canvas_example/canvas_example.dart';
import 'package:custom_painter/gradient_arc.dart';
import 'package:flutter/material.dart';

import 'clipper_vs_painter/clipper_and_painter.dart';
import 'clock.dart';
import 'live_demo.dart';
import 'path_painters/path_example.dart';
import 'widgets/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: true,
      theme: ThemeData.light(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Button(
              title: "Clipper vs Painter",
              page: ClipperAndPainter(),
            ),
            Button(
              title: "Canvas",
              page: CanvasExample(),
            ),
            Button(
              title: "Path",
              page: PathExample(),
            ),
            Button(
              title: "Gradient Arc",
              page: GradientArcPainterDemo(),
            ),
            Button(
              title: "Text",
              page: ArcText(),
            ),
            Button(
              title: "Clock",
              page: ClockPage(),
            ),
            Button(
              title: "Live",
              page: LiveDemo(),
            ),
          ],
        ),
      ),
    );
  }
}
