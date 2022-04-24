import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:zedfi/repositories/auth_repo.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;

  AuthBloc(this._authRepo) : super(AuthInitial()) {
    on<SubmitAuthRequest>(onSubmitAuthRequest);
  }

  void onSubmitAuthRequest(SubmitAuthRequest event, emit) async {
    emit(AuthLoading());
    try {
      if (event.authString.contains('@')) {
        _authRepo.email = event.authString;
        emit(EmailAuth());
      } else {
        //TODO implement phone auth flow
      }
    } on Exception catch (_) {
      rethrow;
    }
  }
}
