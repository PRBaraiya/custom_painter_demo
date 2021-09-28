import 'package:custom_painter/clipper_and_painter.dart';
import 'package:custom_painter/clock.dart';
import 'package:flutter/material.dart';

import 'widgets/button.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
              title: "Clock",
              page: ClockPage(),
            ),
            Button(
              title: "Clipper vs Painter",
              page: ClipperAndPainter(),
            ),
          ],
        ),
      ),
    );
  }
}
