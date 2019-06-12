import 'dart:async';
import 'package:flutter/material.dart';
import '../service/user-service.dart';
import '../model/appointment-model.dart';
import '../service/appointment-service.dart';
import '../widget/mycalendar/month-view.dart';
//import '../calendar-view-bloc.dart';

class CalendarScreen extends StatelessWidget {

  Future<void> _signOut() async {
    try {
      await UserService.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  void dayTapped(DateTime date) {
    try {
      print('Tapped ' + date.month.toString() + '/' + date.day.toString() + '/' + date.year.toString());
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    //CalendarViewBloc bloc = CalendarViewBloc();
    //bloc.selectedDateChanged(DateTime(2019, 06, 11));
    //bloc.selectedDateStream.listen((DateTime date) => print('Tapped ' + date.month.toString() + '/' + date.day.toString() + '/' + date.year.toString()));
    //AppointmentModel available = await AppointmentService.instance.getAvailableAppointments(DateTime.now(), DateTime.now());


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
      body: Row(
        children: <Widget>[
           //mvSB
          Expanded (
                      child:  MonthView(//ScrollingYearsCalendar(
                        // Required properties
                          year: 2019,
                          month: 6,

                          // Optional properties
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

                          daySelected: dayTapped,
                        /*
                        textDecoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(15),
                        ),

                        selectedTextDecoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        */

                      )
                  )

      ]
    ));
  }
}