import 'package:flutter/material.dart';

Color color1 = const Color(0xfffdacc4);
Color color2 = const Color(0xff7969d6);
Color greenLight = const Color(0xff87bc84);
Color color3 = const Color(0xfff8d280);

Color color4 = const Color(0xfffead1d);
Color color5 = const Color(0xff0d0d0d);

// ThemeData lightThemeData(BuildContext context) {
//   return ThemeData.light().copyWith(
//       primaryColor: const Color(0xFF5B4B49),
//       colorScheme: ColorScheme.fromSwatch().copyWith(secondary: greenLight));
// }

// dark Theme

ThemeData darkThemeData(BuildContext context) {
  return ThemeData.dark().copyWith(
      primaryColor: color5,
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: greenLight));
}

ThemeData lightThemeData(BuildContext context) {
  return ThemeData(
      fontFamily: 'Source_Code_Pro',
      primaryColor: const Color(0xFF5B4B49),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: greenLight));
}

// dark Theme
// ThemeData darkThemeData(BuildContext context) {
//   return ThemeData(
//       fontFamily: 'slam',
//       primaryColor: color5,
//       colorScheme: ColorScheme.fromSwatch().copyWith(secondary: greenLight));
// }
