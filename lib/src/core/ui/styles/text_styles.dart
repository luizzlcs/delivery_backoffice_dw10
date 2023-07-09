import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;
  // Avoid self instance
  TextStyles._();
  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get fontfamily => 'mplus1';

  TextStyle get textLight =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: fontfamily);
  TextStyle get textRegular =>
      TextStyle(fontWeight: FontWeight.normal, fontFamily: fontfamily);
  TextStyle get textMidium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: fontfamily);
  TextStyle get textSemiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: fontfamily);
  TextStyle get textBold =>
      TextStyle(fontWeight: FontWeight.bold, fontFamily: fontfamily);
  TextStyle get textExtraBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: fontfamily);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
  TextStyle get textTitle => textExtraBold.copyWith(fontSize: 22);
}

extension TextStyleExtension on BuildContext{
  TextStyles get textStyles => TextStyles.instance; 
}
