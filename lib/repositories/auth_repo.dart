import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  final Map<String, dynamic> phoneAuthStatus = {};

  User get currentUser {
    if (_firebaseAuth.currentUser == null) {
      throw FirebaseAuthException(code: 'user-not-found');
    } else {
      return _firebaseAuth.currentUser!;
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      await currentUser.sendEmailVerification();
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> sendSmsCode({
    required String phoneNumber,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (AuthCredential credential) {
          phoneAuthStatus['triggerAutoSignIn'] = true;
          phoneAuthStatus['autoSignInCreds'] = credential;
        },
        verificationFailed: (FirebaseAuthException exception) {
          throw exception;
        },
        codeSent: (
          String verificationId,
          int? forceResendingToken,
        ) {
          phoneAuthStatus['verificationId'] = verificationId;
          phoneAuthStatus['forceResendingToken'] = forceResendingToken;
        },
        forceResendingToken: phoneAuthStatus['forceResendingToken'],
        codeAutoRetrievalTimeout: (String verificationId) {
          phoneAuthStatus['verificationId'] = verificationId;
        },
      );
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> signInWithCredentials(AuthCredential _credentials) async {
    await _firebaseAuth.signInWithCredential(_credentials);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String _email) async {
    try {
      // Fetch sign-in methods for the email address
      final _list = await _firebaseAuth.fetchSignInMethodsForEmail(_email);
      // In case _list is not empty
      if (_list.isNotEmpty) {
        // Return true because there is an existing
        // user using the email address
        return true;
      } else {
        // Return false because email adress is not in use
        return false;
      }
    } catch (_) {
      rethrow;
    }
  }
}
