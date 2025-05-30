import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color mainColor = const Color(0xff3C69FF);
Color secondary = const Color(0xff3965AA);
TextStyle textStyle = GoogleFonts.poppins(fontSize: 16);

class ThemeApp {
  ThemeData themeDark = ThemeData(
      highlightColor: Colors.grey.shade50,
      brightness: Brightness.dark,
      useMaterial3: true,
      primaryColorDark: Colors.grey,
      canvasColor: const Color(0xff242527),
      shadowColor: Colors.grey.shade200,
      fontFamily: "SF-Pro-Text-RegularItalic",
      primaryColor: CupertinoColors.activeBlue,
      cardColor: const Color(0xff242527),
      scaffoldBackgroundColor: const Color(0xff18191B),
      hintColor: Colors.grey.shade200,
      focusColor: Colors.white.withOpacity(0.6));

  ThemeData themeLight = ThemeData(
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0XFF2EA6D8),
          onPrimary: Color(0xff0D3076),
          secondary: Color(0xff0D3076),
          onSecondary: Color(0xff0D3076),
          error: Colors.red,
          onError: Colors.red,
          surface: Colors.grey,
          onSurface: Colors.grey),
      highlightColor: Colors.grey.shade50,
      brightness: Brightness.light,
      useMaterial3: true,
      primaryColorDark: Colors.grey,
      canvasColor: const Color(0xff242527),
      shadowColor: Colors.white,
      fontFamily: "SF-Pro-Text-RegularItalic",
      primaryColor: CupertinoColors.activeBlue,
      cardColor: Colors.white,
      focusColor: Colors.black,
      hintColor: Colors.grey.shade200,
      scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground);
}
