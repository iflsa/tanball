import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "TanBall - Info",
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
              "Made with love in Flutter by Miłosz Ratajczyk.\nHave fun!\n\nFor more info please visit:\nhttps://github.com/miloszratajczyk/tanball",
              style: TextStyle(fontSize: 30.0),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
