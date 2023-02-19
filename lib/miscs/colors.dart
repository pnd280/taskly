import 'package:flutter/material.dart';

class TasklyColor {
  static const Color greyText = Color(0xFF748497);
  static const Color blackText = Color(0xFF060E17);
  static const Color VeriPeri = Color(0xFF8672EF);
}

class TasklyGradient {
  static const LinearGradient lightBackground = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color.fromRGBO(134, 114, 239, 0.1),
      Color.fromRGBO(123, 105, 217, 0.1),
    ],
  );

  static const LinearGradient purpleBackground = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFF8672EF),
        Color(0xFF7B69D9),
      ]);
}
