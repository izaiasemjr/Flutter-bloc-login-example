import 'package:flutter/material.dart';
import 'colors.dart';

class DecorationsLogin {
  static BoxDecoration borderInput = BoxDecoration(
    color: ColorsCustom.loginScreenUp,
    borderRadius: BorderRadius.circular(25.0),
    border: Border.all(color: Colors.white54, width: 1.0),
  );

  static BoxDecoration backgroundScreen = const BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      // add additional colors to define a multi-point gradient
      colors: [
        ColorsCustom.loginScreenUp,
        ColorsCustom.loginScreenMiddle,
        ColorsCustom.loginScreenDown,
      ],
    ),
  );

  static InputDecoration inputDecorationLogin(
      {@required prefixIcon, suffixIcon, hint = 'your test', label = 'test'}) {
    return InputDecoration(
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: InputBorder.none,
      hintText: hint,
      labelText: label,
      hintStyle: const TextStyle(fontSize: 15.0, color: Colors.white54),
      labelStyle: const TextStyle(fontSize: 15.0, color: Colors.white60),
    );
  }
}

class TextStylesLogin {
  static TextStyle textLink = const TextStyle(
      fontSize: 12,
      color: Colors.white70,
      decoration: TextDecoration.underline);
  static TextStyle textLinkDark = const TextStyle(
      fontSize: 16,
      color: Colors.black54,
      decoration: TextDecoration.underline);
}
