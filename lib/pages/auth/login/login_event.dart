part of 'login_bloc.dart';

abstract class LoginEvent {}

//sending type of event (true or false login)
class ValidateLoginFieldsEvent extends LoginEvent {
  GlobalKey<FormState> key;
  ValidateLoginFieldsEvent(this.key);
}
