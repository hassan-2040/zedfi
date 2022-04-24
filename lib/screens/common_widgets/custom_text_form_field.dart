import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zedfi/constants.dart';
import 'package:zedfi/helpers/app_config.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final Widget? prefixIcon;
  final String? hintText;
  final String? labelText;
  final FocusNode? focusNode;
  final bool autoFocus;
  final bool? obscureText;
  final TextAlign textAlign;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? customValidator;
  final Function(String?)? onFieldSubmitted;
  final Function(String?)? onChanged;
  final TextInputType? keyboardType;

  const CustomTextFormField({
    required this.controller,
    this.autoFocus = false,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.customValidator,
    this.hintText,
    this.focusNode,
    this.obscureText,
    this.inputFormatters,
    this.labelText,
    this.keyboardType,
    this.onFieldSubmitted,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: customValidator,
      focusNode: focusNode,
      autofocus: autoFocus,
      textAlign: textAlign,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      inputFormatters: inputFormatters,
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
