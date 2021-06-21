part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {

}

class LoginButtonTapped  extends LoginEvent{
  String username;
  String password;
  bool isTest;

  LoginButtonTapped({this.username,this.password,this.isTest}) : super();


}

class LoginSuccessDone extends LoginEvent{
  LoginSuccessDone() : super();
}

class LoginError extends LoginEvent {
  LoginError() : super();
}