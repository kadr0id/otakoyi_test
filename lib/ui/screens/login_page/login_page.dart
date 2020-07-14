import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:otakoyi_test/bloc/login_bloc/login_bloc.dart';
import 'package:otakoyi_test/bloc/login_bloc/login_states.dart';
import 'package:otakoyi_test/thema.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController;
  TextEditingController _passwordController;
  bool _passwordVisible;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
//    double textfieldpadding = ((13.0 * width) / WIDTH);
//    double dinopadding = ((7.2 * width) / WIDTH);
    bool _obscureText = true;
    final loginBloc = BlocProvider.of<LoginBloc>(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoadingLoginState) {
              showDialog(
                context: context,
                child: Center(
                  child: Container(
                    width: 48.0,
                    height: 48.0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }
          },
        ),
        BlocListener<LoginBloc, LoginState>(condition: (previousState, state) {
          return previousState is LoadingLoginState;
        }, listener: (context, state) {
          Navigator.of(context).pop();
          if (state is LoginSuccessState) {
            Navigator.of(context).pushReplacementNamed('/feeds');
          } else if (state is ApiLoginErrorState) {
            _scaffoldKey.currentState.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              duration: Duration(seconds: 10),
            ));
          }
        }),
      ],
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            //  _buildBackground(context),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(color: Colors.green),
            )

          ],
        ),
      ),
    );
  }

  bool showEmailValidationError(LoginBloc loginBloc) {
    if (loginBloc.currentState is LoginFieldsErrorState) {
      LoginFieldsErrorState errorState = loginBloc.currentState;
      return errorState.error.emailError != null &&
          errorState.error.emailError.isNotEmpty;
    } else
      return false;
  }

  bool showPasswordValidationError(LoginBloc loginBloc) {
    if (loginBloc.currentState is LoginFieldsErrorState) {
      LoginFieldsErrorState errorState = loginBloc.currentState;
      return errorState.error.passwordError != null &&
          errorState.error.passwordError.isNotEmpty;
    } else
      return false;
  }

  Widget error(String error) => Padding(
        padding: EdgeInsets.only(left: 18.0, top: 4.0),
        child: new Text(
          error,
          style: TextStyle(
            fontSize: 10.0,
            //color: error
          ),
        ),
      );

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
