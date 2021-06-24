import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bn_staff/core/constants.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(InitialLoginState initialLoginState) : super(InitialLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if (event is LoginButtonTapped) {
        yield LoginLoaing();

        Response result = await LoginApiProvider().getSession(
            (event as LoginButtonTapped).username,
            (event as LoginButtonTapped).password,
            (event as LoginButtonTapped).isTest);
        SharedPreferences prefs = await SharedPreferences.getInstance();

        var data = result.data;

        if (data['status'] == 0) {
          print('Error');
          yield LoginErrorState('Invalid Credentials Entered');;
        }
        else {
          var c = result.data['session_id'];

          await prefs.setString(Config.SESSION_ID_KEY, c);
          await prefs.setString(
              Config.SESSION_USERNAME_KEY, (event as LoginButtonTapped).username);
          await prefs.setString(
              Config.SESSION_PASSWORD_KEY, (event as LoginButtonTapped).password);
          await prefs.setBool(
              Config.SESSION_IS_TEST_KEY, (event as LoginButtonTapped).isTest);

          yield LoginSuccess();
        }

      }
    } catch (e) {
      yield LoginErrorState(e.toString());
    }
  }
}
