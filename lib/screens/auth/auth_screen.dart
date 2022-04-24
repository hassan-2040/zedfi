import 'package:flutter/material.dart';
import 'package:zedfi/utilities/app_config.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: AppConfig.screenHeight * 0.1),
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.backspace),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Expanded(
                  child: Text('Connect your Wallet'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
