

import 'package:flutter/material.dart';

///printing only in debug mode
void printInfo(String info) {
  debugPrint("DEBUG MODE: $info");
}

///checking for string presence in text field
String? defaultValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a value';
  }
  return null;
}