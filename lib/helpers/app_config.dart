import 'package:flutter/material.dart';
import 'package:zedfi/constants.dart';

class AppConfig {
  static const primaryColor = Color(0xFF683ab7);
  static const primaryColorLight = Color(0xFFc5a3ff);
  static const backgroundColor = Color(0xFFede3ff);
  static const primaryColorDark = Color(0xFF3c1d73);

  static late MediaQueryData _mediaQueryData;

  //screen info/config
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late bool smallDevice;

  //text size config
  static late double _textSizeMainHeading;
  static late double _textSizeSubHeading;
  static late double _textSizeLarge;
  static late double _textSizeNormal;
  static late double _textSizeSmall;

  static TextStyle getTextStyle({
    Color? textColor,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    TextSize? textSize,
    TextDecoration? textDecoration,
  }) {
    late final double _size;

    switch (textSize) {
      case TextSize.main:
        _size = _textSizeMainHeading;
        break;
      case TextSize.sub:
        _size = _textSizeSubHeading;
        break;
      case TextSize.large:
        _size = _textSizeLarge;
        break;
      case TextSize.normal:
        _size = _textSizeNormal;
        break;
      case TextSize.small:
        _size = _textSizeSmall;
        break;
      default:
        _size = 14;
        break;
    }

    return TextStyle(
      color: textColor,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      fontSize: _size,
      decoration: textDecoration,
    );
  }

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    if (screenWidth > 300 && screenHeight > 600) {
      smallDevice = false;
    } else {
      smallDevice = true;
    }

    //setting text size based on screen size
    if (smallDevice) {
      _textSizeMainHeading = 23;
      _textSizeSubHeading = 18;
      _textSizeLarge = 15;
      _textSizeNormal = 13;
      _textSizeSmall = 10;
    } else {
      _textSizeMainHeading = 30;
      _textSizeSubHeading = 21;
      _textSizeLarge = 18;
      _textSizeNormal = 16;
      _textSizeSmall = 12;
    }

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }
}
