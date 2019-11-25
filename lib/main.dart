import 'package:flutter/material.dart';
import 'package:tanball/screens/InfoScreen.dart';
import 'package:tanball/screens/MenuScreen.dart';
import 'package:tanball/screens/PlayScreen.dart';
import 'package:tanball/screens/StatsScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Kurale',
      ),
      routes: {
        '/': (ctx) => MenuScreen(),
        '/play': (ctx) => PlayScreen(),
        '/stats': (ctx) => StatsScreen(),
        '/info': (ctx) => InfoScreen(),
      },
    );
  }
}
