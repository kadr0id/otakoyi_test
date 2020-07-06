import 'package:bloc/bloc.dart';
import 'package:otakoyi_test/bloc/login_bloc/login_events.dart';
import 'package:otakoyi_test/bloc/login_bloc/login_states.dart';
import 'package:otakoyi_test/models/loggin_fields_error.dart';
import 'package:otakoyi_test/models/token_response.dart';
import 'package:otakoyi_test/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:otakoyi_test/models/errors.dart' as error;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  SharedPreferences sharedPreferences;
  final String emailPattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  LoginBloc(this.sharedPreferences) {
    userRepository = UserRepository(sharedPreferences);
  }

  @override
  // TODO: implement initialState
  LoginState get initialState => IdleLoginState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is SubmitLoginEvent) {
      String emailError = validateEmail(event.request.email);
      String passError = validatePassword(event.request.password);
      if (emailError != null || passError != null) {
        yield LoginFieldsErrorState(LoginFieldsError(
          emailError: emailError,
          passwordError: passError,
        ));
      } else {
        yield LoadingLoginState();
        dynamic response = await userRepository.login(event.request);
        if (response is error.Error) {
          yield ApiLoginErrorState(response.errorMessage);
        } else {
          await userRepository.storeToken((response as TokenResponse).token);
          yield LoginSuccessState();
        }
      }
    } else if (event is SetFieldsLoginEvent) {
      yield IdleLoginState(email: event.email, password: event.password);
    }
  }

  String validateEmail(
    String email,
  ) {
    RegExp exp = new RegExp(emailPattern);
    if (!exp.hasMatch(email)) {
      return "Email is not valid";
    } else {
      return null;
    }
  }

  String validatePassword(String password) {
    if (password.length < 8) {
      return "Password is too short";
    } else {
      return null;
    }
  }
}
