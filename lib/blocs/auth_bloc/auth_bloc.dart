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

  late final Map<String, dynamic> _phoneAuthStatus;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<SubmitAuthRequest>(onSubmitAuthRequest);
    on<SubmitEmailAuth>(onSubmitEmailAuth);
  }

  //using the string provided to route to phone or email auth flow
  void onSubmitAuthRequest(SubmitAuthRequest event, emit) async {
    emit(AuthScreenLoading());
    try {
      if (event.authString.contains('@')) {
        email = event.authString;
        emit(EmailAuth());
      } else {
        await _phoneVerification(event.authString);
        emit(PhoneAuth());
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

  Future<void> _phoneVerification(String _phone) async {
    _phoneAuthStatus = await _authRepo.sendSmsCode(phoneNumber: _phone);

    printInfo('phone auth status: $_phoneAuthStatus');
  }
}
