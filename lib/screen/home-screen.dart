import 'dart:async';
import 'package:flutter/material.dart';
import '../service/user-service.dart';
import 'calendar-screen.dart';

class HomeScreen extends StatelessWidget {

  Future<void> _signOut() async {
    try {
      await UserService.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
      body: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome ' + UserService.instance.user.firstName),
                CalendarScreen(),
              ]
      ),
    );
  }
}