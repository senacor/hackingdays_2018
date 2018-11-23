import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Welcome to Flutter Breakout'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class MyGamePage extends StatefulWidget {
  MyGamePage({Key key, @required this.levelIndex}) : super(key: key);
  final int levelIndex;
  @override
  _GameState createState() => _GameState(levelIndex);
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Center(child: Text(widget.title),),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(
                        builder: (context) => MyGamePage(levelIndex: 0,),
                  ),
                  );
                },
                child: Text(
                  'Level 1', textScaleFactor: 2.0
                ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => MyGamePage(levelIndex: 1,),
                ),
                );
              },
              child: Text(
                  'Level 2', textScaleFactor: 2.0
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => MyGamePage(levelIndex: 2,),
                ),
                );
              },
              child: Text(
                  'Level 3', textScaleFactor: 2.0
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => MyGamePage(levelIndex: 3,),
                ),
                );
              },
              child: Text(
                  'Level 4', textScaleFactor: 2.0
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context, MaterialPageRoute(
                  builder: (context) => MyGamePage(levelIndex: 4,),
                ),
                );
              },
              child: Text(
                  'Level 5', textScaleFactor: 2.0
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}

class StartScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('def'),
      ),
    );
  }
}

enum GameStatus {
  running,
  justLostLife,
  won,
  preGame,
  lost
}

class _GameState extends State<MyGamePage>
    with SingleTickerProviderStateMixin {
  _GameState(int i){
    this.levelIndex = i;
  }

  GameStatus state = GameStatus.preGame;
  int lives = 5;
  double ballXPos = 10;
  double ballYPos = 100;
  static double initialSpeed = 2.0;
  double speed = initialSpeed;
  double speedIncrease = 0.05;
  double maxSpeed = 5;
  double _dx = 2;
  double _dy = 1;
  double _noHitForFrames = 0;
  double pedalPosX = 250;
  double pedalPosY = 270;
  double pedalSize = 100;
  double fieldWidth = 600;
  double fieldHeight = 300;
  final fieldPaddingX = 40;
  final fieldPaddingY = 70;
  int levelIndex = 0;
  final Stopwatch stopwatch = new Stopwatch();
  static BreakOutLevel level1 = new BreakOutLevel([
    Brick( 50, 30, 20, 100, 5),
    Brick(150, 30, 20, 100, 5),
    Brick(250, 30, 20, 100, 5),
    Brick(350, 30, 20, 100, 5),
    Brick(450, 30, 20, 100, 5),
    Brick( 50, 50, 20, 100, 4),
    Brick(150, 50, 20, 100, 4),
    Brick(250, 50, 20, 100, 4),
    Brick(350, 50, 20, 100, 4),
    Brick(450, 50, 20, 100, 4),
    Brick( 50, 70, 20, 100, 3),
    Brick(150, 70, 20, 100, 3),
    Brick(250, 70, 20, 100, 3),
    Brick(350, 70, 20, 100, 3),
    Brick(450, 70, 20, 100, 3),
    Brick( 50, 90, 20, 100, 2),
    Brick(150, 90, 20, 100, 2),
    Brick(250, 90, 20, 100, 2),
    Brick(350, 90, 20, 100, 2),
    Brick(450, 90, 20, 100, 2),
    Brick( 50, 110, 20, 100, 1),
    Brick(150, 110, 20, 100, 1),
    Brick(250, 110, 20, 100, 1),
    Brick(350, 110, 20, 100, 1),
    Brick(450, 110, 20, 100, 1),
  ], 'Level 1');
  static BreakOutLevel level2 = new BreakOutLevel([
    // x,y,h,w,s
    // Top row
    Brick(  0,  30, 20,  50, 2),
    Brick( 50,  30, 20,  50, 2),
    Brick(100,  30, 20,  50, 2),
    Brick(150,  30, 20,  50, 2),
    Brick(200,  30, 20,  50, 2),
    Brick(250,  30, 20,  50, 2),
    Brick(300,  30, 20,  50, 2),
    Brick(350,  30, 20,  50, 2),
    Brick(400,  30, 20,  50, 2),
    Brick(450,  30, 20,  50, 2),
    Brick(500,  30, 20,  50, 2),
    Brick(550,  30, 20,  50, 2),
    // Row 2
    Brick(  0,  50, 20,  50, 2),
    Brick( 50,  50, 20,  50, 2),
    Brick(100,  50, 20,  50, 2),
    Brick(150,  50, 20,  50, 2),
    Brick(200,  50, 20,  50, 2),
    Brick(250,  50, 20,  50, 2),
    Brick(300,  50, 20,  50, 2),
    Brick(350,  50, 20,  50, 2),
    Brick(400,  50, 20,  50, 2),
    Brick(450,  50, 20,  50, 2),
    Brick(500,  50, 20,  50, 2),
    Brick(550,  50, 20,  50, 2),
    // Row 3
    Brick(  0,  90, 20,  50, 3),
    Brick( 50,  90, 20,  50, 3),
    Brick(100,  90, 20,  50, 3),
    Brick(150,  90, 20,  50, 3),
    Brick(200,  90, 20,  50, 3),
    Brick(250,  90, 20,  50, 3),
    Brick(300,  90, 20,  50, 3),
    Brick(350,  90, 20,  50, 3),
    Brick(400,  90, 20,  50, 3),
    Brick(450,  90, 20,  50, 3),
    Brick(500,  90, 20,  50, 3),
    Brick(550,  90, 20,  50, 3),
    // Row 4
    Brick(  0,  130, 20,  50, 2),
    Brick( 50,  130, 20,  50, 2),
    Brick(100,  130, 20,  50, 2),
    Brick(150,  130, 20,  50, 2),
    Brick(200,  130, 20,  50, 2),
    Brick(250,  130, 20,  50, 2),
    Brick(300,  130, 20,  50, 2),
    Brick(350,  130, 20,  50, 2),
    Brick(400,  130, 20,  50, 2),
    Brick(450,  130, 20,  50, 2),
    Brick(500,  130, 20,  50, 2),
    Brick(550,  130, 20,  50, 2),
    // Row 5
    Brick(  0,  150, 20,  50, 2),
    Brick( 50,  150, 20,  50, 2),
    Brick(100,  150, 20,  50, 2),
    Brick(150,  150, 20,  50, 2),
    Brick(200,  150, 20,  50, 2),
    Brick(250,  150, 20,  50, 2),
    Brick(300,  150, 20,  50, 2),
    Brick(350,  150, 20,  50, 2),
    Brick(400,  150, 20,  50, 2),
    Brick(450,  150, 20,  50, 2),
    Brick(500,  150, 20,  50, 2),
    Brick(550,  150, 20,  50, 2),
  ], 'Level 2');
  static BreakOutLevel level3 = new BreakOutLevel([
    // Top Row
    Brick( 0, 10, 20, 600, 5),
    // Center
    Brick( 50,  30, 20, 100, 2),
  //  Brick(150,  30, 20, 100, 5),
    Brick(250,  30, 20, 100, 2),
 //   Brick(350,  30, 20, 100, 5),
    Brick(450,  30, 20, 100, 2),
//    Brick( 50,  50, 20, 100, 5),
    Brick(150,  50, 20, 100, 5),
//    Brick(250,  50, 20, 100, 5),
    Brick(350,  50, 20, 100, 5),
 //   Brick(450,  50, 20, 100, 5),
    Brick( 50,  70, 20, 100, 2),
  //  Brick(150,  70, 20, 100, 5),
    Brick(250,  70, 20, 100, 5),
   // Brick(350,  70, 20, 100, 5),
    Brick(450,  70, 20, 100, 2),
  //  Brick( 50,  90, 20, 100, 5),
    Brick(150,  90, 20, 100, 5),
  //  Brick(250,  90, 20, 100, 5),
    Brick(350,  90, 20, 100, 5),
 //   Brick(450,  90, 20, 100, 5),
    Brick( 50, 110, 20, 100, 2),
 //   Brick(150, 110, 20, 100, 5),
    Brick(250, 110, 20, 100, 2),
 //   Brick(350, 110, 20, 100, 5),
    Brick(450, 110, 20, 100, 2),
    // Bottom Row
    Brick( 0, 130, 20, 600, 5),
  ], 'Level 3');
  static BreakOutLevel level4 = new BreakOutLevel([
    // Top row
    Brick( 100,  20, 20,  50, 2),
    Brick( 150,  20, 20,  50, 2),
    Brick( 400,  20, 20,  50, 2),
    Brick( 450,  20, 20,  50, 2),
    // 2
    Brick(  50,  40, 20,  50, 2),
    Brick( 100,  40, 20,  50, 3),
    Brick( 150,  40, 20,  50, 3),
    Brick( 200,  40, 20,  50, 2),
    Brick( 350,  40, 20,  50, 2),
    Brick( 400,  40, 20,  50, 3),
    Brick( 450,  40, 20,  50, 3),
    Brick( 500,  40, 20,  50, 2),
    // 3
    Brick(  50,  60, 20,  50, 2),
    Brick( 100,  60, 20,  50, 2),
    Brick( 150,  60, 20,  50, 3),
    Brick( 200,  60, 20,  50, 4),
    Brick( 350,  60, 20,  50, 4),
    Brick( 400,  60, 20,  50, 3),
    Brick( 450,  60, 20,  50, 2),
    Brick( 500,  60, 20,  50, 2),
    //4
    Brick( 100,  80, 20,  50, 2),
    Brick( 150,  80, 20,  50, 3),
    Brick( 200,  80, 20,  50, 4),
    Brick( 250,  80, 20,  50, 5),
    Brick( 300,  80, 20,  50, 5),
    Brick( 350,  80, 20,  50, 4),
    Brick( 400,  80, 20,  50, 3),
    Brick( 450,  80, 20,  50, 2),
    //5
    Brick( 100, 100, 20,  50, 2),
    Brick( 150, 100, 20,  50, 3),
    Brick( 200, 100, 20,  50, 4),
    Brick( 250, 100, 20,  50, 5),
    Brick( 300, 100, 20,  50, 5),
    Brick( 350, 100, 20,  50, 4),
    Brick( 400, 100, 20,  50, 3),
    Brick( 450, 100, 20,  50, 2),
    //6
    Brick( 150, 120, 20,  50, 2),
    Brick( 200, 120, 20,  50, 4),
    Brick( 250, 120, 20,  50, 4),
    Brick( 300, 120, 20,  50, 4),
    Brick( 350, 120, 20,  50, 4),
    Brick( 400, 120, 20,  50, 2),
    // 7
    Brick( 200, 140, 20,  50, 2),
    Brick( 250, 140, 20,  50, 4),
    Brick( 300, 140, 20,  50, 4),
    Brick( 350, 140, 20,  50, 2),
    // 8
    Brick( 250, 160, 20,  50, 2),
    Brick( 300, 160, 20,  50, 2),
  ], 'Level 4');
  static BreakOutLevel level5 = new BreakOutLevel([
    // wrapping top
    Brick(  0, 10, 20,  50, 5),
    Brick( 50, 10, 20,  50, 5),
    Brick(100, 10, 20,  50, 5),
    Brick(150, 10, 20,  50, 5),
    Brick(200, 10, 20,  50, 5),
    Brick(250, 10, 20,  50, 5),
    Brick(300, 10, 20,  50, 5),
    Brick(350, 10, 20,  50, 5),
    Brick(400, 10, 20,  50, 5),
    Brick(450, 10, 20,  50, 5),
    Brick(500, 10, 20,  50, 5),
    Brick(550, 10, 20,  50, 5),
    // core
    Brick( 50, 30, 20, 100, 4),
    Brick(150, 30, 20, 100, 4),
    Brick(250, 30, 20, 100, 4),
    Brick(350, 30, 20, 100, 4),
    Brick(450, 30, 20, 100, 4),
    Brick( 50, 50, 20, 100, 4),
    Brick(150, 50, 20, 100, 3),
    Brick(250, 50, 20, 100, 3),
    Brick(350, 50, 20, 100, 3),
    Brick(450, 50, 20, 100, 4),
    Brick( 50, 70, 20, 100, 4),
    Brick(150, 70, 20, 100, 3),
    Brick(250, 70, 20, 100, 2),
    Brick(350, 70, 20, 100, 3),
    Brick(450, 70, 20, 100, 4),
    Brick( 50, 90, 20, 100, 4),
    Brick(150, 90, 20, 100, 3),
    Brick(250, 90, 20, 100, 3),
    Brick(350, 90, 20, 100, 3),
    Brick(450, 90, 20, 100, 4),
    Brick( 50, 110, 20, 100,4),
    Brick(150, 110, 20, 100,4),
    Brick(250, 110, 20, 100,4),
    Brick(350, 110, 20, 100,4),
    Brick(450, 110, 20, 100,4),
    // wrapping bottom
    Brick(  0, 130, 20,  50, 5),
    Brick( 50, 130, 20,  50, 5),
    Brick(100, 130, 20,  50, 5),
    Brick(150, 130, 20,  50, 5),
    Brick(200, 130, 20,  50, 5),
    Brick(250, 130, 20,  50, 5),
    Brick(300, 130, 20,  50, 5),
    Brick(350, 130, 20,  50, 5),
    Brick(400, 130, 20,  50, 5),
    Brick(450, 130, 20,  50, 5),
    Brick(500, 130, 20,  50, 5),
    Brick(550, 130, 20,  50, 5),
    // wrapping sides
    Brick(  0, 10, 20,  50, 5),
    Brick(  0, 30, 20,  50, 5),
    Brick(  0, 50, 20,  50, 5),
    Brick(  0, 70, 20,  50, 5),
    Brick(  0, 90, 20,  50, 5),
    Brick(  0, 110, 20,  50, 5),
    Brick(550, 10, 20,  50, 5),
    Brick(550, 30, 20,  50, 5),
    Brick(550, 50, 20,  50, 5),
    Brick(550, 70, 20,  50, 5),
    Brick(550, 90, 20,  50, 5),
    Brick(550, 110, 20,  50, 5),
  ], 'Level 5');
  List<BreakOutLevel> levels = [level1, level2, level3, level4, level5];
  Animation<double> animation;
  AnimationController controller;
  bool physicsOn = true;

  void resetGameState() {
    _dx = 0;
    _dy = -2;
    speed = initialSpeed;
    ballXPos = 300;
    ballYPos = 230;
    controller.forward();
    //stopwatch.start();
    }

  void _closeGame() {
    setState(() {
      controller.stop();
      levels[levelIndex].resetLevel();
      stopwatch.stop();
      //this.dispose();
      Navigator.pop(context);

    });
  }


  _onTapDown(TapDownDetails details, BuildContext context) {
  }

  double debugVar = 0.0;

  void updateGameState() {
    if (state != GameStatus.running) return;
    if (_noHitForFrames > 0) _noHitForFrames--;

    if (_noHitForFrames == 0 &&
        pedalPosX <= ballXPos &&
        ballXPos <= pedalPosX + pedalSize &&
        ballYPos >= pedalPosY - 7 &&
        ballYPos <= pedalPosY + 13) {
      _noHitForFrames = 3;

      double posOnPedal = ballXPos - pedalPosX;
//      const double maxFactor = 5.0;
//      double relPosOnPedal;
//      if (_dx < 0) {
//        relPosOnPedal =
//            (posOnPedal - pedalSize / 2) / ((pedalSize / 2) / maxFactor);
//      } else {
//        relPosOnPedal =
//            (pedalSize / 2 - posOnPedal) / ((pedalSize / 2) / maxFactor);
//      }
//      mNew = mNew + (mNew / 6) * relPosOnPedal;
      if (_dx > 0) posOnPedal = pedalSize-posOnPedal;
      double mNew = pow(sqrt(5), (posOnPedal/10 - 5)/3);
      double sign = _dx > 0 ? 1 : -1;
      double dxNew = sign * sqrt((_dy * _dy + _dx * _dx) / (mNew * mNew + 1));
      double dyNew = -sign * mNew * dxNew;

      _dx = dxNew;
      _dy = dyNew;
      speed += speedIncrease;
    } else if (ballYPos >= fieldHeight) {
      loseLife();
    } else if (ballYPos <= 0) {
      _dy = _dy.abs();
//      speed +=  speedIncrease;
    } else if (ballXPos >= fieldWidth) {
      _dx = -(_dx.abs());
    } else if (ballXPos <= 0) {
      _dx = _dx.abs();
//      speed += speedIncrease;
    } else {
      for (Brick b in levels[levelIndex].bricks) {
        if (collided(b)) {
          break;
        }
      }
    }
    if (speed > maxSpeed) speed = maxSpeed;
    ballXPos += _dx * speed;
    ballYPos += _dy * speed;
    if(checkVictory()) {
      setState(() {
        controller.stop();
        stopwatch.stop();
        levels[levelIndex].resetLevel();
        state = GameStatus.won;
      });
    }
  }
  bool checkVictory(){
    //(var is18AndOver = users.every((user) => user[“age”] >= 18);
    if(levels[levelIndex].bricks.any((brick) => brick.strength > 0))
    {
      return  false;
    }
    else {
      return true;
    }
  }

  bool collided(Brick b) {
    if (b.strength <= 0 || _noHitForFrames > 0) {
      return false;
    }

    if (ballXPos >= b.x &&
        ballXPos <= b.x + b.width &&
        ballYPos >= b.y &&
        ballYPos <= b.y + b.height) {
      double hitX = (ballXPos - b.x);
      double hitY = (ballYPos - b.y);

      if (hitY < 5) {
        _dy = -(_dy.abs());
      }

      if (hitY > b.height - 5) {
        _dy = _dy.abs();
      }

      if (hitX <= 5) {
        _dx = -(_dx.abs());
      }

      if (hitX >= b.width - 5) {
        _dx = _dx.abs();
      }

      speed += speedIncrease;
      b.strength--;
      _noHitForFrames = 2;

      return true;
    }

    return false;
  }

  void loseLife() {
    lives--;
    stopwatch.stop();
    state = GameStatus.justLostLife;
    resetGameState();
    if (lives == 0) {
      _dy = 0;
      speed = initialSpeed;
      stopwatch.stop();
      state = GameStatus.lost;
    }
  }

  void _dragPedal(DragUpdateDetails details, BuildContext context) {
    //MediaQuery.of(context).size.width;
    pedalPosX = details.globalPosition.dx - fieldPaddingX - pedalSize / 2;
    if (pedalPosX < 0) pedalPosX = 0;
    if (pedalPosX > fieldWidth - pedalSize) pedalPosX = fieldWidth - pedalSize;
  }

  String getTimeString(Duration d){
    return d.inSeconds.toString();

  }

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    //controller.stop();
    animation = Tween(begin: 0.0, end: 1000.0).animate(controller)
      ..addListener(() {
        setState(() {
          updateGameState();
          // the state that has changed here is the animation object’s value
        });
      });
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    state = GameStatus.preGame;
    controller.forward();
    stopwatch.start();
    resetGameState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(children: [
    //    SizedBox(height: 20.0), // Move toprow outside android header area
        GestureDetector(
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              Expanded(
                child: Row(children: [
                  Icon(IconData(0xe3f3, fontFamily: 'MaterialIcons')),
                  Text(lives.toString(),
                      textAlign: TextAlign.left, textScaleFactor: 3.0),
                ]),
              ),
              Expanded(flex: 2,
                  child: Text(
                      getInGameHeader(),
                      textAlign: TextAlign.center, textScaleFactor: 2.0)),
              Expanded(
                  child: Text(getTimeString(stopwatch.elapsed),
                      textAlign: TextAlign.right, textScaleFactor: 3.0))
            ]),
            onTap: () =>  _closeGame()),
        GestureDetector(
          child: Container(
              width: fieldWidth,
              height: fieldHeight,
              decoration: BoxDecoration(
                color: Colors.teal,
              ),
              child: new CustomPaint(foregroundPainter: new MyPainter(this))),
          onTapDown: (TapDownDetails details) => _onTapDown(details, context),
          onTap: (){
            if(state == GameStatus.preGame) state = GameStatus.running;
            else if(state == GameStatus.justLostLife) {
              state = GameStatus.running;
              stopwatch.start();
            }
            else if (state == GameStatus.lost) Navigator.pop(context);
            else if (state == GameStatus.won) Navigator.pop(context);
          },
          onHorizontalDragUpdate: (DragUpdateDetails details) =>
              _dragPedal(details, context),
        ),
      ]),
    );
  }
  String getInGameHeader(){
    String r = '';
    if(state == GameStatus.running) r = levels[levelIndex].name;
    else if (state == GameStatus.lost) r = 'Oh noes :(';
    else if (state == GameStatus.won) r = 'Victoly!';
    else if (state == GameStatus.justLostLife) r = 'Tap screen to continue';
    else r = 'Tap screen to start';
    return r;
  }
  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MyPainter extends CustomPainter {
  Animation animation;
  _GameState gs;

  MyPainter(_GameState gs) {
    this.gs = gs;
  }

  Paint dot = new Paint()
    ..color = Colors.yellow
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;
  Paint pedal = new Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.fill;
  Paint brickColor = new Paint()
    ..color = Colors.deepOrange
    ..style = PaintingStyle.fill;
  Paint brickOutline = new Paint()
    ..color = Colors.black
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  @override
  void paint(Canvas canvas, Size size) {
    if (gs.state == GameStatus.lost || gs.state == GameStatus.won) return;
    Offset center;
    center = new Offset(this.gs.ballXPos, this.gs.ballYPos);
    double radius = 10;
    canvas.drawCircle(
      center,
      radius,
      dot,
    );
    // draw pedal
    canvas.drawRect(
        Rect.fromLTWH(gs.pedalPosX, gs.pedalPosY, gs.pedalSize, 20), pedal);
    canvas.drawRect(
    Rect.fromLTWH(gs.pedalPosX, gs.pedalPosY, gs.pedalSize, 20), brickOutline);
    for (Brick b in gs.levels[gs.levelIndex].bricks) {
      if (b.strength > 0) {
        canvas.drawRect(
            Rect.fromLTWH(b.x, b.y, b.width, b.height),
            brickColor..color = gs.levels[gs.levelIndex].brickPalette[b.strength]);
        canvas.drawRect(
            Rect.fromLTWH(b.x, b.y, b.width, b.height),
            brickOutline);
      }
    }
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => true;
}

class Brick {
  double x;
  double y;
  double height;
  double width;
  int strength;
  int initialStrength;

  Brick(double x, double y, double h, double w, int s) {
    this.x = x;
    this.y = y;
    this.height = h;
    this.width = w;
    this.strength = s;
    this.initialStrength = s;
  }
}

class BreakOutLevel {
  List<Brick> bricks;
  String name = 'default';
  BreakOutLevel(List<Brick> bricks, String name) {
    this.bricks = bricks;
    this.name = name;
  }

  Map<int, Color> brickPalette = Map.fromEntries([
    MapEntry(1, Colors.white),
    MapEntry(2, Colors.yellow),
    MapEntry(3, Colors.orange),
    MapEntry(4, Colors.deepOrange),
    MapEntry(5, Colors.pink),
  ]);

  resetLevel(){
    for(Brick b in bricks){
      b.strength = b.initialStrength;
    }
  }

}
