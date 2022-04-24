import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  String? email; //using this for saving the email b/w screens only

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

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Returns true if email address is in use.
  Future<bool> checkIfEmailInUse(String _emailAddress) async {
    try {
      // Fetch sign-in methods for the email address
      final _list =
          await _firebaseAuth.fetchSignInMethodsForEmail(_emailAddress);

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
