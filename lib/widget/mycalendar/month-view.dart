import 'package:flutter/material.dart';
import 'day-label.dart';
import 'day-label-state.dart';
import 'calendar-view-bloc.dart';

class MonthView extends StatelessWidget {
  MonthView({
    @required this.year,
    @required this.month,
    this.getTextStyle,
    this.getTextDecoration,
    this.todayColor,
    this.monthNames,
    this.bloc
  });

  final int year;
  final int month;
  final Function getTextStyle;
  final Function getTextDecoration;
  final Color todayColor;
  final List<String> monthNames;
  final CalendarViewBloc bloc;

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
          getTextStyle: this.getTextStyle,
          getTextDecoration: this.getTextDecoration,
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
    print('month: ' + this.month.toString());
    print('year: ' + this.year.toString());
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
                  child: Container(
                            alignment: Alignment.center,
                            child: Text(
                            ((this.month == null)?'':this.monthNames[this.month-1] )+ ', ' + ((this.year == null)?'':this.year.toString()),
                            style: TextStyle(
                              fontSize: 22.0,
                              fontWeight: FontWeight.w600,
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
            child: this.buildWeeks(context),
          ),
        ],
      ),
    );
  }
}