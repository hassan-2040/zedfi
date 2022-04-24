import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';
import 'package:zedfi/helpers/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppConfig().init(context);
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Welcome\nto\nZedfi!',
              textAlign: TextAlign.center,
              style: AppConfig.getTextStyle(
                textSize: TextSize.main,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                      context, AppRouter.pinVerificationScreenRoute);
                  //TODO uncomment
                  // Navigator.pushNamed(context, AppRouter.authScreenRoute);
                },
                child: Text(
                  'Continue',
                  style: AppConfig.getTextStyle(
                    textColor: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
