part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class InitialLoginState extends LoginState {}

class LoginLoaing extends LoginState {}

class LoginSuccess extends LoginState {

  LoginSuccess();

}
class LoginErrorState extends LoginState {

  final String error;
  LoginErrorState(this.error);

}