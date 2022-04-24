part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class SubmitAuthRequest extends AuthEvent {
  final String authString;
  SubmitAuthRequest(this.authString);
}

class SubmitEmailAuth extends AuthEvent {
  final String password;
  SubmitEmailAuth(
    this.password,
  );
}
