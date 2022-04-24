part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

//show loading in auth screen
class AuthScreenLoading extends AuthState {}

//show loading in password screen for email flow
class PasswordScreenLoading extends AuthState {}

class PinScreenLoading extends AuthState {}

//indicating UI to navigate to email auth flow
class EmailAuth extends AuthState {}

//indicatiing UI to navigate to phone auth flow
class PhoneAuth extends AuthState {}

//stoping user to navigate to home if he is unverified
class ShowVerifyEmailScreen extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
