import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';
import 'package:zedfi/screens/common_widgets/custom_text_form_field.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  late Timer _timer;
  int _start = 60;

  late GlobalKey<FormState> _formKey;

  late final TextEditingController _firstDigitController;
  late final TextEditingController _secondDigitController;
  late final TextEditingController _thirdDigitController;
  late final TextEditingController _fourthDigitController;
  late final TextEditingController _fifthDigitController;
  late final TextEditingController _sixthDigitController;

  late final FocusNode _secondDigitFocusNode;
  late final FocusNode _thirdDigitFocusNode;
  late final FocusNode _fourthDigitFocusNode;
  late final FocusNode _fifthDigitFocusNode;
  late final FocusNode _sixthDigitFocusNode;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _firstDigitController = TextEditingController();
    _secondDigitController = TextEditingController();
    _thirdDigitController = TextEditingController();
    _fourthDigitController = TextEditingController();
    _fifthDigitController = TextEditingController();
    _sixthDigitController = TextEditingController();

    //no need for first focus node as we handle it with autofocus
    _secondDigitFocusNode = FocusNode();
    _thirdDigitFocusNode = FocusNode();
    _fourthDigitFocusNode = FocusNode();
    _fifthDigitFocusNode = FocusNode();
    _sixthDigitFocusNode = FocusNode();

    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _firstDigitController.dispose();
    _secondDigitController.dispose();
    _thirdDigitController.dispose();
    _fourthDigitController.dispose();
    _fifthDigitController.dispose();
    _sixthDigitController.dispose();

    _secondDigitFocusNode.dispose();
    _thirdDigitFocusNode.dispose();
    _fourthDigitFocusNode.dispose();
    _fifthDigitFocusNode.dispose();
    _sixthDigitFocusNode.dispose();

    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    const _oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      _oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: AppConfig.screenHeight,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: AppConfig.screenHeight * 0.1,
                    ),
                    Text(
                      'We have sent you a code',
                      textAlign: TextAlign.center,
                      style: AppConfig.getTextStyle(
                        textSize: TextSize.main,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Enter the confirmation code below',
                      textAlign: TextAlign.center,
                      style: AppConfig.getTextStyle(
                        textSize: TextSize.large,
                        textColor: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  autoFocus: true,
                                  obscureText: true,
                                  textAlign: TextAlign.center,
                                  controller: _firstDigitController,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(_secondDigitFocusNode);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  controller: _secondDigitController,
                                  focusNode: _secondDigitFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(_thirdDigitFocusNode);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  controller: _thirdDigitController,
                                  focusNode: _thirdDigitFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(_fourthDigitFocusNode);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  controller: _fourthDigitController,
                                  focusNode: _fourthDigitFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(_fifthDigitFocusNode);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  controller: _fifthDigitController,
                                  focusNode: _fifthDigitFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      FocusScope.of(context)
                                          .requestFocus(_sixthDigitFocusNode);
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: CustomTextFormField(
                                  obscureText: true,
                                  controller: _sixthDigitController,
                                  focusNode: _sixthDigitFocusNode,
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  onChanged: (_s) {
                                    if (_s != null && _s.isNotEmpty) {
                                      //TODO submit pin
                                    }
                                  },
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Didn\'t receive code? ',
                            style: AppConfig.getTextStyle(
                              textColor: Colors.grey,
                              textSize: TextSize.small,
                            ),
                          ),
                          Visibility(
                            visible: _start != 0,
                            child: Text(
                              'Wait for $_start seconds',
                              style: AppConfig.getTextStyle(
                                textColor: Colors.black,
                                textSize: TextSize.small,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: _start == 0,
                            child: RawMaterialButton(
                              onPressed: () {
                                setState(() {
                                  _start = 60;
                                });
                                _startTimer();
                                //TODO resend pin
                              },
                              child: Text(
                                'Resend Sms',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.black,
                                  textSize: TextSize.small,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: AppConfig.screenHeight * 0.1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
