import 'dart:async';
import 'package:flutter/material.dart';
import '../../service/user-service.dart';
import '../../model/appointment-model.dart';
import '../../service/appointment-service.dart';
import '../../widget/mycalendar/month-view.dart';
import 'calendar-view-bloc.dart';

class CalendarView extends StatelessWidget {

  Future<void> _signOut() async {
    try {
      await UserService.instance.signOut();
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  void dayTapped(CalendarViewBloc bloc, DateTime date) {
    try {
      print('Tapped ' + date.month.toString() + '/' + date.day.toString() + '/' + date.year.toString());
      bloc.selectedDateChanged(date);
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  @override
  Widget build(BuildContext context) {
    CalendarViewBloc bloc = CalendarViewBloc();
    bloc.selectedDateChanged(DateTime(2019, 06, 11));
    bloc.selectedDateStream.listen((DateTime date) => print('Tapped ' + date.month.toString() + '/' + date.day.toString() + '/' + date.year.toString()));
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
          FlatButton(
            onPressed: () => bloc.viewDateChanged(DateTime(bloc.viewDate.year, bloc.viewDate.month-1, 1)),
            padding: const EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.blue,
                //borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                '<',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              )
            )
          ),
           //mvSB
          StreamBuilder<DateTime>(
                stream: bloc.viewDateStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  return Expanded (
                      child:  MonthView(//ScrollingYearsCalendar(
                        // Required properties
                          year: snapshot.data.year,
                          month: snapshot.data.month,
                          bloc: bloc,

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

                          //getColor: (DateTime dt) => Colors.green,

                          //getBackground: (DateTime dt) => Colors.blue,

                          getTextDecoration: (DateTime dt) => BoxDecoration(
                            color: (bloc.selectedDate == dt)?Colors.blue:Colors.white,
                            //borderRadius: BorderRadius.circular(40),
                          )

                      )
                  );
                } else {
                  return Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },/*
                builder: (context, snapshot) => Expanded (
                    child:  Text(
                  snapshot.data?.year.toString(),
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),

                )
          )*/
            ),

          FlatButton(
              onPressed: () => bloc.viewDateChanged(DateTime(bloc.viewDate.year, bloc.viewDate.month+1, 1)),
              padding: const EdgeInsets.all(0.0),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    //borderRadius: BorderRadius.circular(40),
                  ),
                  child: Text(
                    '>',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  )
              )
          ),
      ]
    ));
  }
}