import 'dart:async';
import 'package:flutter/material.dart';
import '../service/user-service.dart';
import '../widget/calendar/scrolling_years_calendar.dart';

class CalendarScreen extends StatelessWidget {

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
      body: ScrollingYearsCalendar(
              // Required properties
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now().subtract(Duration(days: 5 * 365)),
              lastDate: DateTime.now(),

              // Optional properties
              todayColor: Colors.blue,
              monthNames: const <String>[
                'Jan',
                'Feb',
                'Mar',
                'Apr',
                'May',
                'Jun',
                'Jul',
                'Aug',
                'Sep',
                'Oct',
                'Nov',
                'Dec',
              ],
              onMonthTap: (int year, int month) => print('Tapped $month/$year'),
      ),
    );
  }
}