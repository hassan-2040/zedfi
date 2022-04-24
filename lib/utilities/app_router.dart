import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/screens/welcome/welcome_screen.dart';

class AppRouter {
  //app route names
  static const String homeScreenRoute = '/homeScreen';
  static const String welcomeScreenRoute = '/welcomeScreen';
  static const String loginScreenRoute = '/loginScreen';

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
      // case homeScreenRoute:
      //   return MaterialPageRoute(
      //     builder: (_) => const HomeScreen(),
      //   );
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
