part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthScreenLoading extends AuthState {}

class PasswordScreenLoading extends AuthState {}

class EmailAuth extends AuthState {}

class PhoneAuth extends AuthState {}

class ShowVerifyEmailScreen extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
}
