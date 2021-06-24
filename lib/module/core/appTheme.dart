import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData pickAppTheme(BuildContext context) {
  ThemeData _themeDefault = ThemeData(
    scaffoldBackgroundColor: Color(0xFF1F487E),
    primaryColor: Color(0xFF33598A),
    accentColor: Color(0xFF05B2DC),
    shadowColor: Color(0xFF0D1930),
    cardColor: Color(0xFFB3C2F2),
    highlightColor: Colors.amber,
    cardTheme: CardTheme(
      color: Color(0xFF466895),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
      elevation: 8,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1D3461),
      selectedItemColor: Color(0xFF6682A8),
      unselectedItemColor: Color(0xFF33598A),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF6ED0F3),
      foregroundColor: Color(0xFF1F487E),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
      },
    ),
    fontFamily: 'Roboto',
    textTheme: TextTheme(
      headline1: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
      headline2: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
      headline3: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
      headline4: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
      headline5: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
      headline6: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFFE0F2E9),),
      ),
    ),
    accentTextTheme: TextTheme(
      headline1: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
      headline2: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
      headline3: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
      headline4: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
      headline5: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
      headline6: GoogleFonts.robotoSlab(
        textStyle: TextStyle(color: Color(0xFF1F487E),),
      ),
    ),
  );
  return _themeDefault;
}