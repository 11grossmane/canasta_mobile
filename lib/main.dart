import 'package:flutter/material.dart';
import 'package:my_app/home.dart';
import 'package:my_app/login.dart';
import 'package:my_app/store/gameStore.dart';
import './titleSection.dart' as t;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GameModel.state.setInitialCardPositions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter layout demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
