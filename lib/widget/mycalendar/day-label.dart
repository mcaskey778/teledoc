import 'package:flutter/material.dart';
import 'day-label-state.dart';
import 'calendar-view-bloc.dart';

class DayLabel extends StatelessWidget {
  const DayLabel({
    @required this.dayLabelState,
    this.textDecoration,
    this.selectedTextDecoration,
    this.textStyle,
    this.selectedTextStyle,
    this.todayDecoration,
    this.todayStyle,
    this.bloc,
  });

  final DayLabelState dayLabelState;
  final BoxDecoration textDecoration;
  final BoxDecoration selectedTextDecoration;
  final TextStyle textStyle;
  final TextStyle selectedTextStyle;
  final BoxDecoration todayDecoration;
  final TextStyle todayStyle;
  final CalendarViewBloc bloc;

  TextStyle getStyle() {
    TextStyle ts;
    if (!this.dayLabelState.isInMonth) {
      ts = TextStyle(
        color: Colors.grey,
        fontSize: 22.0,
        fontWeight: FontWeight.normal,
      );
    } else {
      if (this.dayLabelState.curDate == bloc.selectedDate) {
        ts = this.selectedTextStyle ?? TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        );
      } else {
        ts = this.textStyle ?? TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.w600,
        );
      }
    }
    return ts;
  }

  BoxDecoration getDecoration() {
    BoxDecoration bd;
    if (!this.dayLabelState.isInMonth) {
      bd = null;
    } else {
      if (this.dayLabelState.curDate == bloc.selectedDate) {
        bd = this.selectedTextDecoration ?? BoxDecoration(
          color: Colors.blue,
          //borderRadius: BorderRadius.circular(40),
        );
      } else {
        bd = this.textDecoration ?? BoxDecoration(
          color: Colors.white,
          //borderRadius: BorderRadius.circular(40),
        );
      }
    }
    return bd;
  }

  @override
  Widget build(BuildContext context) {
    String lbl = '0' + ((this.dayLabelState.curDate != null)?
                        this.dayLabelState.curDate.day.toString():
                        '0');
    lbl = lbl.substring(lbl.length - 2, lbl.length);

    return StreamBuilder<DateTime>(
      stream: bloc.selectedDateStream,
      builder: (context, snapshot) => Expanded(
        child: Container(
            alignment: Alignment.center,
            decoration: getDecoration(),
            child: (bloc != null) ?
            FlatButton(
              onPressed: () => (this.dayLabelState.isInMonth) ? bloc.selectedDateChanged(this.dayLabelState.curDate) : null,
              padding: const EdgeInsets.all(0.0),
              child: Text(
                lbl,
                style: getStyle(),
              ),
            ) : Text(
              lbl,
              style: getStyle(),
            )
        )
      )
    );
  }
}