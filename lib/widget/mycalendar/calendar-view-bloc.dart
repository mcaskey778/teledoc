import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../../validator/date-validator.dart';

class CalendarViewBloc  {
  final _selectedDateController = BehaviorSubject<DateTime>();
  final _viewDateController = BehaviorSubject<DateTime>();

  CalendarViewBloc() {
    this.viewDateChanged(DateTime(2019, 6, 1));

    viewDateStream.listen((DateTime dt) {
      print(dt.month.toString() + '/' + dt.day.toString() + '/' + dt.year.toString());
    });
  }

  Function(DateTime) get selectedDateChanged => _selectedDateController.sink.add;
  Function(DateTime) get viewDateChanged => _viewDateController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<DateTime> get selectedDateStream => _selectedDateController.stream;
  DateTime get selectedDate => _selectedDateController.value;

  Stream<DateTime> get viewDateStream => _viewDateController.stream;
  DateTime get viewDate => _viewDateController.value;

  void dispose() {
    _selectedDateController?.close();
    _viewDateController?.close();
  }
}

