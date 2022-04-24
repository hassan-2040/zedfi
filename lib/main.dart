import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/screens/welcome/welcome_screen.dart';
import 'package:zedfi/utilities/app_config.dart';
import 'package:zedfi/utilities/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: buttonColor,
            onPrimary: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      initialRoute: AppRouter.welcomeScreenRoute,
      onGenerateInitialRoutes: AppRouter.generateInitialRoute,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
