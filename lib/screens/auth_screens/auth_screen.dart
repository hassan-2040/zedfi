import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zedfi/blocs/auth_bloc/auth_bloc.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';
import 'package:zedfi/helpers/app_router.dart';
import 'package:zedfi/helpers/utilities.dart';
import 'package:zedfi/screens/common_widgets/custom_text_form_field.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _authController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _authController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _authController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: AppConfig.screenHeight,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Stack(
          children: [
            Column(
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
                Text(
                  'We\'ll send you a confirmation code',
                  style: AppConfig.getTextStyle(
                    textSize: TextSize.large,
                    textColor: Colors.grey,
                  ),
                )
              ],
            ),
            Form(
              key: _formKey,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: CustomTextFormField(
                        controller: _authController,
                        keyboardType: TextInputType.emailAddress,
                        customValidator: (_s) => defaultValidator(_s),
                        prefixIcon: const Icon(
                          Icons.flag,
                          color: Colors.red,
                        ),
                        labelText: 'Phone Number or Email',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is EmailAuth) {
                          Navigator.pushNamed(
                              context, AppRouter.passwordScreenRoute);
                        }

                        if (state is PhoneAuth) {
                          //TODO navigate to pin screen and send sms
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthScreenLoading) {
                          return SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                  Theme.of(context).indicatorColor,
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                    SubmitAuthRequest(_authController.text),
                                  );
                                }
                              },
                              child: Text(
                                'Continue',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'By Signing up I agree to Zedfi\'s ',
                          style: AppConfig.getTextStyle(
                            textColor: Colors.grey,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'Privacy Policy',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }),
                            TextSpan(
                              text: ' and ',
                              style: AppConfig.getTextStyle(
                                textColor: Colors.grey,
                              ),
                            ),
                            TextSpan(
                                text: 'Terms of Use ',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }),
                            TextSpan(
                                text:
                                    'and allow Zedfi to use your information for future',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.grey,
                                )),
                            TextSpan(
                                text: ' Marketing purposes.',
                                style: AppConfig.getTextStyle(
                                  textColor: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // open desired screen
                                  }),
                          ]),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
