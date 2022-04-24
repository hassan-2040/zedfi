import 'package:firebase_auth/firebase_auth.dart';
import 'package:zedfi/helpers/utilities.dart';

String customErrorResponses(Exception _error) {
  late String _response;

  if (_error is FirebaseAuthException) {
    switch (_error.code) {
      case 'invalid-email':
        _response = "Invalid Email Provided. Please use your correct email.";
        break;
      case 'email-already-in-use':
        _response =
            "Email already used. Please sign in or use a different email.";
        break;
      case 'user-not-found':
        _response = "User not found. Please login again or sign up.";
        break;
      case 'wrong-password':
        _response = "Incorrect password. Please try again.";
        break;
      case 'user-profile-already-exists':
        _response = "User Profile Already Exists";
        break;
        case 'email-not-provided':
        _response = 'Email not provided';
        break;
      default:
        _response = "Cannot Authenticate for unknown error";
        break;
    }
  } else if (_error is FirebaseException) {
      _response = "Failure: ${_error.code}";
      printInfo('full error message: ${_error.message}');
    
  } else {
    _response = "Error: ${_error.toString()}";
  }
  return _response;
}
