import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zedfi/helpers/constants.dart';
import 'package:zedfi/helpers/app_config.dart';
import 'package:zedfi/helpers/app_router.dart';
import 'package:zedfi/repositories/auth_repo.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(
        const Duration(
          seconds: 3,
        ), (_timer) {
      _checkEmailVerification();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _checkEmailVerification() async {
    final _user = RepositoryProvider.of<AuthRepo>(context).currentUser;
    await _user.reload();
    if (_user.emailVerified) {
      _timer.cancel();

      //removing all screens in stack and pushing to home screen
      //also stopping from returning to previous screens with back button
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRouter.homeScreenRoute,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                    child: FittedBox(
                      child: Text(
                        'Connect your wallet',
                        style: AppConfig.getTextStyle(
                          textSize: TextSize.main,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'An Email has been sent to you for verification. Once you verify your email, you will be redirected to home.',
                textAlign: TextAlign.center,
                style: AppConfig.getTextStyle(
                  textSize: TextSize.large,
                  textColor: Colors.grey,
                ),
              ),
              Expanded(
                  child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).indicatorColor,
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
