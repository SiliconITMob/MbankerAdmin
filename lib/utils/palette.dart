import 'package:flutter/material.dart';
class Palette {
  static const MaterialColor customMaterial = MaterialColor(
    0xfff9f8f8, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xfffaf9f9 ),//10%
      100:  Color(0xfffaf9f9),//20%
      200:  Color(0xfffbfafa),//30%
      300:  Color(0xfffbfbfb),//40%
      400:  Color(0xfffbfbfb),//50%
      500:  Color(0xfff9f8f8),//60%
      600:  Color(0xfffbfbfb),//70%
      700:  Color(0xfffbfbfb),//80%
      800:  Color(0xfffbfbfb),//90%
      900:  Color(0xfff9f8f8),//100%
    },
  );
}