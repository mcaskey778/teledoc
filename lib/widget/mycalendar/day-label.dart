import 'package:flutter/material.dart';
import 'day-label-state.dart';
import 'calendar-view-bloc.dart';

class DayLabel extends StatelessWidget {
  const DayLabel({
    @required this.dayLabelState,
    this.getTextStyle,
    this.getTextDecoration,
    this.bloc,
  });

  final DayLabelState dayLabelState;
  final Function getTextStyle;
  final Function getTextDecoration;
  final CalendarViewBloc bloc;

  @override
  Widget build(BuildContext context) {
    String lbl = '0' + ((this.dayLabelState.curDate != null)?
                        this.dayLabelState.curDate.day.toString():
                        '0');
    lbl = lbl.substring(lbl.length - 2, lbl.length);

    Widget txtBox = Text(
        lbl,
        style: (this.dayLabelState.isInMonth && (this.getTextStyle!=null)) ?
        this.getTextStyle(this.dayLabelState.curDate) :
        TextStyle(
          color: (this.dayLabelState.isInMonth) ? Colors.black : Colors.grey,
          fontSize: 22.0,
          fontWeight: (this.dayLabelState.isInMonth) ? FontWeight.w600 : FontWeight.normal,
        ),
    );

    return StreamBuilder<DateTime>(
      stream: bloc.selectedDateStream,
      builder: (context, snapshot) => Expanded(
        child: Container(
            alignment: Alignment.center,
            decoration: (this.dayLabelState.isInMonth && (this.getTextDecoration!=null)) ?
                          this.getTextDecoration(this.dayLabelState.curDate) : null,
            child: (bloc != null) ?
            FlatButton(
              onPressed: () => (this.dayLabelState.isInMonth) ? bloc.selectedDateChanged(this.dayLabelState.curDate) : null,
              padding: const EdgeInsets.all(0.0),
              child: txtBox,
            ) : txtBox
        )
      )
    );
  }
}