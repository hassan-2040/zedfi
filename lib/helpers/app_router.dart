import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/screens/auth/auth_screen.dart';
import 'package:zedfi/screens/email_verification/email_verification_screen.dart';
import 'package:zedfi/screens/home/home_screen.dart';
import 'package:zedfi/screens/password/password_screen.dart';
import 'package:zedfi/screens/welcome/welcome_screen.dart';

class AppRouter {
  //app route names
  static const String homeScreenRoute = '/homeScreen';
  static const String welcomeScreenRoute = '/welcomeScreen';
  static const String authScreenRoute = '/authScreen';
  static const String passwordScreenRoute = '/passwordScreen';
  static const String emailVerificationScreenRoute = '/emailVerificationScreen';

  ///Used this function to make sure the home attribute of MaterialApp is not rendered
  ///in addition to the required screens. If this is not overridden, an extra screen pops up
  ///in the beginning of the navigation stack, as the base route '/'.
  ///See https://api.flutter.dev/flutter/widgets/WidgetsApp/initialRoute.html
  static List<Route<dynamic>> generateInitialRoute(String _string) {
    //use a switch statement to match strings to screens based on use-case
    return [
      MaterialPageRoute(
        builder: (_) => const WelcomeScreen(),
      ),
    ];
  }

  static Route<dynamic> generateRoute(RouteSettings _settings) {
    switch (_settings.name) {
      case welcomeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
        );
      case authScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
        );
      case passwordScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const PasswordSceen(),
        );
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case emailVerificationScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const EmailVerificationScreen(),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${_settings.name}'),
            ),
          ),
        );
    }
  }
}
