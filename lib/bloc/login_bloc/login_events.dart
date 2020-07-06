import 'package:equatable/equatable.dart';
import 'package:otakoyi_test/models/loggin_fields_error.dart';
import 'package:otakoyi_test/models/login_reqest.dart';

abstract class LoginEvent extends Equatable {}

class SetFieldsLoginEvent extends LoginEvent {
  String email;
  String password;

  SetFieldsLoginEvent({this.email, this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'SetFieldsLoginEvent{email: $email, password: $password}';
  }
}

class SubmitLoginEvent extends LoginEvent {
  LoginRequest request;

  SubmitLoginEvent(this.request);

  @override
  List<Object> get props => [request];

  @override
  String toString() {
    return 'SubmitLoginEvent{request: $request}';
  }
}



class LoginFieldsErrorEvent extends LoginEvent {
  LoginFieldsError error;

  LoginFieldsErrorEvent(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'LoginFieldsErrorEvent{error: $error}';
  }
}


class LoginLoadingEvent extends LoginEvent{
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return 'LoginLoadingEvent{}';
  }
}

class ApiErrorLoginEvent extends LoginEvent{
  String error;
  ApiErrorLoginEvent(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ApiErrorLoginEvent{error: $error}';
  }
}


class LoginSuccessEvent extends LoginEvent{
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return 'LoginSuccessEvent{}';
  }
}