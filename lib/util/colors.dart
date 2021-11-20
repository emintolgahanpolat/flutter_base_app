import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const MaterialColor primarySwatch = MaterialColor(
    _primarySwatchValue,
    <int, Color>{
      50: Color(0xffffefe6),
      100: Color(0xfffedfcd),
      200: Color(0xfffdbe9b),
      300: Color(0xfffc9e69),
      400: Color(0xfffb7d37),
      500: Color(_primarySwatchValue),
      600: Color(0xffc84a04),
      700: Color(0xff963803),
      800: Color(0xff642502),
      900: Color(0xff321301)
    },
  );
  static const int _primarySwatchValue = 0xFFEC6E00;
  static const Color divider = Color(0xFFF3F3F3);
  static const Color white = Color(0xFFFFFFFF);
  static const Color blue = Color(0xFF027BFF);
  static const Color red = Color(0xFFF44336);
  static const Color black = Color(0xFF000000);
  static const Color grey = Color(0xFF717171);
  static const Color lightGrey = Color(0xFFebebec);
  static const Color transparent = Color(0x00000000);

  static const Color chatBlue = Color(0xFFe9f5ff);
  static const Color green = Color(0xFF30d126);

  static const Color text = Color(0xFF444444);

  static const Color facebook = Color(0xFF3b5998);
  static const Color apple = Color(0xFF000000);
  static const Color google = Color(0xFFdd482f);

  static const LinearGradient gradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [green, primarySwatch]);
  static Color get random =>
      Colors.primaries[Random().nextInt(Colors.primaries.length)];
}

extension ColorsEx on Color {
  MaterialColor toMaterial() {
    return MaterialColor(value, _getSwatch(this));
  }

  Map<int, Color> _getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    const lowDivisor = 6;
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}
