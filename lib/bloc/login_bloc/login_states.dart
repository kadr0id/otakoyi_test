import 'package:equatable/equatable.dart';
import 'package:otakoyi_test/models/loggin_fields_error.dart';
import 'package:otakoyi_test/models/login_reqest.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super();
}

class IdleLoginState extends LoginState {
  String email;
  String password;

  IdleLoginState({this.email = "", this.password = ""});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() {
    return 'InitialLoginState{email: $email, password: $password}';
  }
}

class LoginFieldsErrorState extends LoginState {
  LoginFieldsError error;

  LoginFieldsErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'LoginFieldsErrorState{error: $error}';
  }
}

class SubmitLoginState extends LoginState {
  LoginRequest request;

  SubmitLoginState(this.request);

  @override
  // TODO: implement props
  List<Object> get props => [request];

  @override
  String toString() {
    return 'SubmitLoginState{request: $request}';
  }
}

class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => null;

  @override
  String toString() {
    return 'LoadingLoginState{}';
  }
}

class ApiLoginErrorState extends LoginState {
  String error;

  ApiLoginErrorState(this.error);

  @override
  List<Object> get props => [error];

  @override
  String toString() {
    return 'ApiLoginErrorState{error: $error}';
  }
}

class LoginSuccessState extends LoginState {
  @override
  String toString() {
    return 'LoginSuccessState{}';
  }

  @override
  List<Object> get props => null;
}
