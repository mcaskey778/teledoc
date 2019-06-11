import 'package:flutter/material.dart';

class DayLabelState {
  DayLabelState({
    @required this.year,
    @required this.month,
    @required this.day,
  }) {
    if(this.month != null && this.year != null) {
      int firstWeekDay = DateTime(this.year, this.month, 1).weekday;
      print('firstWeekDay: ' + firstWeekDay.toString());
      if(firstWeekDay == 7) firstWeekDay = 0;
      int dayNum = this.day - firstWeekDay + 1;
      this.curDate = DateTime(year, month, dayNum);
    }
  }

  final int year;
  final int month;
  final int day;
  DateTime curDate;

  bool get isInMonth => (this.curDate!=null)?
                          this.curDate.month == this.month && this.curDate.year == this.year:
                          false;
}