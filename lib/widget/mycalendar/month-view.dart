import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'day-label.dart';
import 'day-label-state.dart';
import 'calendar-view-bloc.dart';

class MonthView extends StatelessWidget {
  MonthView({
    int year,
    int month,
    this.textDecoration,
    this.selectedTextDecoration,
    this.textStyle,
    this.selectedTextStyle,
    this.todayDecoration,
    this.todayStyle,
    this.monthNames,
    this.daySelected,
  }) {
    this.year = year;
    this.month = month;
    if (this.daySelected != null)
      bloc.selectedDateStream.listen(daySelected);
  }

  set year(int y) => bloc.viewDateChanged(DateTime(y, this.month, 1));
  int get year => bloc.viewDate?.year;

  set month(int m) => bloc.viewDateChanged(DateTime(this.year, m, 1));
  int get month => bloc.viewDate?.month;

  final BoxDecoration textDecoration;
  final BoxDecoration selectedTextDecoration;
  final TextStyle textStyle;
  final TextStyle selectedTextStyle;
  final BoxDecoration todayDecoration;
  final TextStyle todayStyle;
  final List<String> monthNames;
  final CalendarViewBloc bloc = CalendarViewBloc();
  final Function daySelected;

/*
  Widget buildDays(BuildContext context, int week) {
    final List<Widget> days = <Widget>[];

    final int skipDays = DateTime(year, month, 1).weekday;
    int dayCount = 7;
    if(week == 0){
      dayCount -= skipDays;
      int skipOffset = DateTime(year, month, 0).day;
      for(int sd = skipDays-1; sd >= 0; sd--){
        String lbl = ' ' + (skipOffset - sd).toString();
        lbl = lbl.substring(lbl.length - 2, lbl.length);
        days.add(Expanded(
            child: Text(
              lbl,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            )
          )
        );
      }
      for(int wd = 1; wd <= dayCount; wd++){
        String lbl = ' ' + wd.toString();
        lbl = lbl.substring(lbl.length - 2, lbl.length);
        days.add(Expanded(
            child: Text(
             lbl,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            )
          )
        );
      }
    } else {
      for (int wd = 1; wd <= dayCount; wd++) {
        String lbl = ' ' + ((week * 7) + wd - skipDays).toString();
        lbl = lbl.substring(lbl.length - 2, lbl.length);
        print('[' + lbl + ']');
        days.add(
          Expanded(
            child: Text(
              lbl,
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            )
          )
        );
      }
    }

    return Row(
      children: days
    );
  }
*/

  Widget buildWeeks(BuildContext context) {
    final List<Row> weeks = <Row>[];

    DayLabel lastDay;
    int weekCount = 0;
    do {
      List<DayLabel> weekDays = <DayLabel>[];
      for (int i = 0; i < 7; i++) {
        lastDay = DayLabel(
          bloc: bloc,
          dayLabelState : DayLabelState(
            year: year,
            month: month,
            day: i + (weekCount*7)),
          textDecoration: this.textDecoration,
          selectedTextDecoration: this.selectedTextDecoration,
          textStyle: this.textStyle,
          selectedTextStyle: this.selectedTextStyle,
          todayDecoration: this.todayDecoration,
          todayStyle: this.todayStyle,
        );
        weekDays.add(lastDay);
      }
      weekCount++;
      weeks.add(
          Row(
            children: List<DayLabel>.from(weekDays),
          )
      );
    } while (lastDay.dayLabelState.isInMonth);

    return Column(
      children: weeks,
    );
  }

  @override
  Widget build(BuildContext context) {
    var monthFormatter = new DateFormat('MMMM, yyyy');
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            child: Row(
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
                Expanded(
                  child: StreamBuilder<DateTime>(
                    stream: bloc.viewDateStream,
                    builder: (context, snapshot) => Container(
                      alignment: Alignment.center,
                      child: Text(
                        (snapshot.data!=null)?monthFormatter.format(snapshot.data):'',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
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
            )
          ),
          Container(
            child: Divider(
              color: Colors.black26,
            ),
          ),
          Container(
            child: StreamBuilder<DateTime>(
              stream: bloc.viewDateStream,
              builder: (context, snapshot) => this.buildWeeks(context),
            ),
          ),
        ],
      ),
    );
  }
}