part of 'login_bloc.dart';

abstract class LoginState {}

// validate or not validate
class LoginInitial extends LoginState {}

class ValidLoginFields extends LoginState {}

class LoginFailureState extends LoginState {
  String errorMessage;

  LoginFailureState({required this.errorMessage});
}
