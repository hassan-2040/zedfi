import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:zedfi/helpers/custom_error_responses.dart';
import 'package:zedfi/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  String? email; //using this for saving the email b/w screens only

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<SubmitAuthRequest>(onSubmitAuthRequest);
    on<SubmitEmailAuth>(onSubmitEmailAuth);
  }

  void onSubmitAuthRequest(SubmitAuthRequest event, emit) async {
    emit(AuthScreenLoading());
    try {
      if (event.authString.contains('@')) {
        email = event.authString;
        emit(EmailAuth());
      } else {
        //TODO implement phone auth flow
      }
    } on Exception catch (_) {
      rethrow;
    }
  }

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
}
