import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({ Key? key }) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
                        'We have sent you a code',
                        style: AppConfig.getTextStyle(
                          textSize: TextSize.main,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  'Enter the confirmation code below',
                  style: AppConfig.getTextStyle(
                    textSize: TextSize.large,
                    textColor: Colors.grey,
                  ),
                )
              ],
            ),
    );
  }
}