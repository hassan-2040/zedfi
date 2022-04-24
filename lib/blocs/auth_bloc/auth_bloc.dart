import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:zedfi/helpers/custom_error_responses.dart';
import 'package:zedfi/helpers/utilities.dart';
import 'package:zedfi/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  String? email; //using this for saving the email b/w screens only
  String? phone; //using this for resend OTP flow

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<SubmitAuthRequest>(onSubmitAuthRequest);
    on<SubmitEmailAuth>(onSubmitEmailAuth);
    on<SubmitPhoneAuth>(onSubmitPhoneAuth);
    on<ResendOTP>(onResendOTP);
  }

  //using the string provided to route to phone or email auth flow
  void onSubmitAuthRequest(SubmitAuthRequest event, emit) async {
    emit(AuthScreenLoading());
    try {
      if (event.authString.contains('@')) {
        email = event.authString;
        emit(EmailAuth());
      } else {
        if (_phoneFormatInvalid(event.authString)) {
          throw FirebaseAuthException(code: 'invalid-phone');
        }

        await _authRepo.sendSmsCode(phoneNumber: event.authString);

        phone = event.authString;

        //waiting for the send sms code block to finish processing
        await Future.delayed(const Duration(seconds: 2));

        emit(PhoneAuth());
      }
    } on Exception catch (_error) {
      emit(AuthFailure(customErrorResponses(_error)));
    }
  }

  void onResendOTP(ResendOTP event, emit) async {
    try {
      if (phone != null) {
        await _authRepo.sendSmsCode(phoneNumber: phone!);
      } else {
        throw FirebaseAuthException(code: 'phone-not-provided');
      }
    } on Exception catch (_error) {
      emit(AuthFailure(customErrorResponses(_error)));
    }
  }

  //submitting email and password login/sign up flow and making sure user is verified
  void onSubmitEmailAuth(SubmitEmailAuth event, emit) async {
    emit(PasswordScreenLoading());
    try {
      if (email != null) {
        final _accountExists = await _authRepo.checkIfEmailInUse(email!);
        if (_accountExists) {
          await _authRepo.signInWithEmailAndPassword(
            email: email!,
            password: event.password,
          );
        } else {
          await _authRepo.createUserWithEmailAndPassword(
            email: email!,
            password: event.password,
          );
        }
        if (_authRepo.currentUser.emailVerified) {
          emit(AuthSuccess());
        } else {
          await _authRepo.sendVerificationEmail();
          emit(ShowVerifyEmailScreen());
        }
      } else {
        throw FirebaseAuthException(
          code: 'email-not-provided',
        );
      }
    } on Exception catch (_error) {
      emit(AuthFailure(customErrorResponses(_error)));
    }
  }

  Future<void> onSubmitPhoneAuth(SubmitPhoneAuth event, emit) async {
    emit(PinScreenLoading());
    try {
      // Create a PhoneAuthCredential with the code
      PhoneAuthCredential _credential = PhoneAuthProvider.credential(
        verificationId: event.verificationId,
        smsCode: event.pin,
      );

      // Sign the user in (or link) with the credential
      await _authRepo.signInWithCredentials(_credential);
      emit(AuthSuccess());
    } on Exception catch (_error) {
      emit(AuthFailure(customErrorResponses(_error)));
    }
  }

  bool _phoneFormatInvalid(String _phoneNumber) {
    if (_phoneNumber.length != 13 && _phoneNumber[0] != '+') {
      return true;
    }
    ;
    if (int.tryParse(_phoneNumber.split('+')[1]) == null) {
      return true;
    }

    return false;
  }
}
