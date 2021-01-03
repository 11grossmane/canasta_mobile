import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/01-components/Grid.dart';
import 'package:my_app/02-pages/login.dart';
import 'package:my_app/helpers.dart';
import 'package:my_app/store/gameStore.dart';

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
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Grid(),
    );
  }
}
