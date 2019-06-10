import 'dart:async';
import 'package:rxdart/rxdart.dart';
import '../validator/user-validator.dart';
import '../bloc/base-bloc.dart';

class LoginBloc implements BaseBloc {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Function(String) get emailChanged => _emailController.sink.add;
  Function(String) get passwordChanged => _passwordController.sink.add;

  //Another way
  // StreamSink<String> get emailChanged => _emailController.sink;
  // StreamSink<String> get passwordChanged => _passwordController.sink;

  Stream<String> get emailStream => _emailController.stream.transform(UserValidators.emailValidator);
  String get email => _emailController.value;
  Stream<String> get passwordStream => _passwordController.stream.transform(UserValidators.passwordValidator);
  String get password => _passwordController.value;

  Stream<bool> get submitCheck => Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);

  submit() {
    print("${_emailController.value}");
  }

  @override
  void dispose() {
    _emailController?.close();
    _passwordController?.close();
  }
}

