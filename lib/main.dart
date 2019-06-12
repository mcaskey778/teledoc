import 'package:flutter/material.dart';
//import 'screen/landing.dart';
import 'screen/calendar-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: CalendarScreen(),//LandingPage(),
    );
  }
}