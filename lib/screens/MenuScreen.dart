import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key key}) : super(key: key);

  void _playBtn(ctx) {
    Navigator.pushNamed(ctx, '/play');
  }

  void _statsBtn(ctx) {
    Navigator.pushNamed(ctx, '/stats');
  }

  void _infoBtn(ctx) {
    Navigator.pushNamed(ctx, '/info');
  }

  void _exitBtn() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TanBall",
          style: TextStyle(
            fontFamily: "Kurale",
            fontSize: 30.0,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () => _playBtn(context),
              child: SizedBox(
                width: 200.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Play",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
              onPressed: () => _statsBtn(context),
              child: SizedBox(
                width: 200.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Stats",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            RaisedButton(
              onPressed: () => _infoBtn(context),
              child: SizedBox(
                width: 200.0,
                height: 50.0,
                child: Center(
                  child: Text(
                    "Info",
                    style: TextStyle(fontSize: 30.0),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            if (!kIsWeb)
              RaisedButton(
                onPressed: () => _exitBtn(),
                child: SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: Center(
                    child: Text(
                      "Exit",
                      style: TextStyle(fontSize: 30.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
