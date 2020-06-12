import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  static TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.roboto(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    headline2: GoogleFonts.roboto(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    headline3: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
    headline4: GoogleFonts.roboto(
        fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
    headline6: GoogleFonts.roboto(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    subtitle1: GoogleFonts.roboto(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    subtitle2: GoogleFonts.roboto(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyText1: GoogleFonts.rubik(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyText2: GoogleFonts.rubik(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    button: GoogleFonts.rubik(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    caption: GoogleFonts.rubik(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    overline: GoogleFonts.rubik(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  static final TabBarTheme _tabBarTheme = TabBarTheme(
    indicator: BoxDecoration(
      color: Colors.transparent.withOpacity(0.2),
      borderRadius: BorderRadius.circular(50),
    ),
    labelColor: Colors.white,
    labelPadding: const EdgeInsets.symmetric(horizontal: 8.0),
    labelStyle: const TextStyle(fontWeight: FontWeight.w600),
    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  static final InputDecorationTheme _inputTheme = const InputDecorationTheme(
    border: const UnderlineInputBorder(),
    filled: false,
  );

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.teal,
    accentColor: Colors.redAccent,
    tabBarTheme: _tabBarTheme,
    inputDecorationTheme: _inputTheme,
    textTheme: _textTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.grey[900],
    accentColor: Colors.teal[400],
    scaffoldBackgroundColor: Colors.grey[800],
    inputDecorationTheme: _inputTheme,
    tabBarTheme: _tabBarTheme,
    textTheme: _textTheme,
  );
}
