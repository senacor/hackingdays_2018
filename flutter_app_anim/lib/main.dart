import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(
          title: 'Flutter Animation Test ' +
              Random.secure().nextInt(1000).toString()),
    );
  }
}

class IconDisplayState extends State<IconDisplay>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 30000), vsync: this);
    animation = Tween(begin: 0.0, end: 60000.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  Widget build(BuildContext context) {
    var boxHeight = MediaQuery.of(context).size.height;
    var boxWidth = MediaQuery.of(context).size.width;
    var progress = animation.value / 60000;
    var remaining = 1 - progress;
    return Stack(alignment: Alignment.center, children: <Widget>[
      Positioned(
// Circling inwards
          top: (sin(animation.value / 1200) * boxHeight / 4) * remaining +
              boxHeight / 2 - 50,
          left: (cos(animation.value / 1200) * boxWidth / 4) * remaining +
              boxWidth / 2 - 50,
// Up-down with horizontal sinus curve
//          top: (sin(animation.value / 1200) * boxHeight / 4) +
//              boxHeight / 2 - 50,
//          left: (sin(animation.value / 300) * boxWidth / 4) * remaining +
//              boxWidth / 2 - 50,
          child: Transform.rotate(
            angle: animation.value / 1200,
            child: Transform.scale(
                scale: remaining,
                child: Container(
                  height: 100,
                  width: 100,
                  child: FlutterLogo(),
                )),
          ))
    ]);
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class IconDisplay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return IconDisplayState();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: IconDisplay(),
      ),
    );
  }
}
