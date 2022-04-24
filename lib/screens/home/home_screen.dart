import 'package:flutter/material.dart';
import 'package:zedfi/helpers/constants.dart';
import 'package:zedfi/helpers/app_config.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Text('Home', style: AppConfig.getTextStyle(textSize: TextSize.main,),),
        ),
      ),
    );
  }
}