import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:quiver/async.dart' show CountdownTimer;

import 'package:flutter/material.dart';

class PlayScreen extends StatefulWidget {
  PlayScreen({Key key}) : super(key: key);

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> animation;

  double _getWidth(ctx) => MediaQuery.of(ctx).size.width - 50.0;
  double _getHeight(ctx) => MediaQuery.of(ctx).size.height - 200.0;

  double _slid1Val = 0.5;
  double _slid2Val = 0.5;
  AnimationController controller;
  double basketX = 100.0;
  double basketY = 200.0;

  int madePoints = 0;
  int missedPoints = 0;

  void randomBasket() {
    var r = Random();
    basketX =
        (r.nextInt(MediaQuery.of(context).size.width ~/ 2.0) + 20).toDouble();
    basketY = (r.nextInt(MediaQuery.of(context).size.height ~/ 2)).toDouble();
  }

  String _appBarText = "";
  void missed() {
    print("missed");
    _appBarText = "YOU MISSED IT! ;C";
    randomBasket();
    controller.reverse().then((_) => count());
    missedPoints++;
  }

  void made() {
    print("made");
    _appBarText = "YOU MADE IT! :D";
    randomBasket();
    controller.reverse().then((_) => count());
    madePoints++;
  }

  void count() async {
    var x = CountdownTimer(Duration(seconds: 4), Duration(seconds: 1));
    var y = x.listen(null);
    y.onData((counter) {
      setState(() {
        _appBarText = "Time left: ${counter.remaining.inSeconds + 1}";
      });
    });
    y.onDone(() {
      print("I'm done with this");

      controller.forward();
      setState(() {
        _appBarText = "Shooting!";
      });
      y.cancel();
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 2),
      reverseDuration: Duration(seconds: 1),
      vsync: this,
    );
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _fraction = animation.value;
        });
      });
    count();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            _appBarText.toString(),
            style: TextStyle(
              fontFamily: "Kurale",
              fontSize: 30.0,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Center(
                    child: Text(
                      "$madePoints:$missedPoints",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 150.0, color: Colors.black26),
                    ),
                  ),
                  CustomPaint(
                    willChange: true,
                    size: Size(_getWidth(context), _getHeight(context)),
                    painter: MyPainter(
                      () => _slid1Val,
                      () => _slid2Val,
                      _fraction,
                      missed,
                      made,
                      basketX,
                      basketY,
                    ),
                  ),
                ],
              ),
              Flexible(
                child: Flex(
                  direction: MediaQuery.of(context).size.width >
                          MediaQuery.of(context).size.height
                      ? Axis.horizontal
                      : Axis.vertical,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Angle",
                                textAlign: TextAlign.right,
                              )),
                          Expanded(
                            flex: 8,
                            child: Slider.adaptive(
                              value: _slid1Val,
                              onChanged: (newVal) {
                                if (_fraction == 0)
                                  setState(() {
                                    _slid1Val = newVal;
                                  });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Flex(
                        direction: Axis.horizontal,
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                              flex: 1,
                              child: Text(
                                "Range",
                                textAlign: TextAlign.right,
                              )),
                          Expanded(
                            flex: 8,
                            child: Slider.adaptive(
                              value: _slid2Val,
                              onChanged: (newVal) {
                                if (_fraction == 0)
                                  setState(() {
                                    _slid2Val = newVal;
                                  });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  double f(x, y, z) => x * y * (z - x) / z;

  Function getSlid1;
  Function getSlid2;
  double fraction;
  Function missed;
  Function made;
  double baskX;
  double baskY;
  MyPainter(this.getSlid1, this.getSlid2, this.fraction, this.missed, this.made,
      this.baskX, this.baskY);
//Painters
  var borderPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;
  var playerPaint = Paint()
    ..color = Colors.white
    ..strokeWidth = 2
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;
  var ballLinesPaint = Paint()
    ..color = Colors.red
    ..strokeWidth = 2
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;
  var ballPaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;
  var basketPaint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 5
    ..style = PaintingStyle.fill
    ..strokeCap = StrokeCap.round;

  void paintStuff(canvas, size, i) {
    //Offsets
    var basket1Offset = Offset(
      baskX,
      baskY,
    );
    var basket2Offset = Offset(
      baskX + 50.0,
      baskY,
    );

    //Draw border
    canvas.drawLine(
      Offset(0.0, size.height),
      Offset(size.width, size.height),
      borderPaint,
    );

    //Draw player
    canvas
      ..drawCircle(
        Offset(size.width - 35.0, size.height - 80.0),
        15.0,
        playerPaint,
      )
      ..drawLine(
        Offset(size.width - 35.0, size.height - 80.0),
        Offset(size.width - 35.0, size.height - 40.0),
        playerPaint,
      )
      ..drawLine(
        Offset(size.width - 35.0, size.height - 40.0),
        Offset(size.width - 40.0, size.height - 20.0),
        playerPaint,
      )
      ..drawLine(
        Offset(size.width - 35.0, size.height - 40.0),
        Offset(size.width - 35.0, size.height - 20.0),
        playerPaint,
      )
      ..drawLine(
        Offset(size.width - 40.0, size.height - 20.0),
        Offset(size.width - 40.0, size.height - 0.0),
        playerPaint,
      )
      ..drawLine(
        Offset(size.width - 35.0, size.height - 20.0),
        Offset(size.width - 30.0, size.height - 00.0),
        playerPaint,
      );

    //Draw ball lines
    for (double i = 0; i + 50 < size.width; i += 10) {
      var res =
          f(i, size.height / 100 * getSlid1(), size.width * 1.5 * getSlid2());
      canvas.drawCircle(Offset(i, size.height - 90.0), 2.0, ballLinesPaint);
      if (res > -40)
        canvas.drawCircle(
          Offset(
            size.width - i - 50.0,
            size.height - 90.0 - res,
          ),
          2.0,
          ballLinesPaint,
        );
    }

    //Draw ball
    var res =
        f(i, size.height / 100 * getSlid1(), size.width * 1.5 * getSlid2());
    if (i >= size.width) missed();

    if (res >= 0) {
      var ballOffset = Offset(
        size.width - 50.0 - i,
        size.height - 90.0 - res,
      );
      canvas.drawCircle(
        ballOffset,
        15.0,
        ballPaint,
      );
      if (basket1Offset.dx + 10 < ballOffset.dx &&
          ballOffset.dx < basket2Offset.dx - 10 &&
          ballOffset.dy < basket1Offset.dy + 50 &&
          ballOffset.dy > basket1Offset.dy - 10) made();
    } else
      missed();

    //Draw basket
    canvas.drawLine(basket1Offset, basket2Offset, basketPaint);

    //Draw hands
    if (i < 50 || i > 150)
      canvas
        ..drawLine(Offset(size.width - 50.0, size.height - 80.0),
            Offset(size.width - 50.0, size.height - 60.0), playerPaint)
        ..drawLine(Offset(size.width - 50.0, size.height - 60.0),
            Offset(size.width - 35.0, size.height - 65.0), playerPaint)
        ..drawLine(Offset(size.width - 55.0, size.height - 75.0),
            Offset(size.width - 55.0, size.height - 65.0), playerPaint)
        ..drawLine(Offset(size.width - 55.0, size.height - 65.0),
            Offset(size.width - 35.0, size.height - 65.0), playerPaint);
    else
      canvas
        ..drawLine(Offset(size.width - 35.0, size.height - 70.0),
            Offset(size.width - 50.0, size.height - 120.0), playerPaint)
        ..drawLine(Offset(size.width - 70.0, size.height - 100.0),
            Offset(size.width - 55.0, size.height - 80.0), playerPaint)
        ..drawLine(Offset(size.width - 55.0, size.height - 80.0),
            Offset(size.width - 35.0, size.height - 65.0), playerPaint);
  }

  @override
  void paint(Canvas canvas, Size size) async {
    paintStuff(canvas, size, fraction * size.width);
  }

  @override
  bool shouldRepaint(MyPainter old) {
    return old.fraction != fraction;
  }
}
