import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final bool? obscureText;
  final String? Function(String?)? customValidator;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    required this.controller,
    this.prefixIcon,
    this.customValidator,
    this.hintText,
    this.obscureText,
    this.labelText,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: customValidator,
      obscureText: obscureText ?? false,
      style: AppConfig.getTextStyle(
        textSize: TextSize.sub,
        textColor: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        hintText: hintText,
        labelText: labelText,
        labelStyle: AppConfig.getTextStyle(
          textSize: TextSize.large,
          textColor: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
