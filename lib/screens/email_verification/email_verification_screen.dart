import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: AppConfig.screenHeight * 0.1),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Connect your wallet',
                    style: AppConfig.getTextStyle(
                      textSize: TextSize.main,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Text(
                'An Email has been sent to you for verification. Once you verify your email, you will be redirected to home.',
                textAlign: TextAlign.center,
                style: AppConfig.getTextStyle(
                  textSize: TextSize.large,
                  textColor: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
