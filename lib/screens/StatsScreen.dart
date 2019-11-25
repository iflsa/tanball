import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TanBall - Stats",
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
            Text(
              "TODO: ADD STATS!",
              style: TextStyle(fontSize: 30.0),
            )
          ],
        ),
      ),
    );
  }
}
