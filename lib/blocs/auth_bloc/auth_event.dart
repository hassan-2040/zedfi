part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

//used to verify phone or email auth flow
class SubmitAuthRequest extends AuthEvent {
  final String authString;
  SubmitAuthRequest(this.authString);
}

//submitting email auth flow
class SubmitEmailAuth extends AuthEvent {
  final String password;
  SubmitEmailAuth(
    this.password,
  );
}

// class SubmitPhoneAuth extends AuthEvent {
//   final String phoneNumber;
//   SubmitPhoneAuth(
//     this.phoneNumber,
//   );
// }
