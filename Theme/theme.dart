import 'package:flutter/material.dart';

const _primaryColor = Colors.white;

final dartTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor, brightness: Brightness.dark),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: Color(0xFFFFFFFF),
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D5FF0),
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFF313036),
      )),
  primaryColor: Colors.black38,
  hintColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.black12,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    
    displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
    // bodyLarge: TextStyle(fontSize: 16, color: Colors.white),
    // bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    labelLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Color(0xFF333333),
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: _primaryColor, brightness: Brightness.light),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      // backgroundColor: Color(0xFFFFFFFF),
      selectedIconTheme: IconThemeData(
        color: Color(0xFF5D5FF0),
      ),
      unselectedIconTheme: IconThemeData(
        color: Color(0xFF313036),
      )),
  primaryColor: Colors.white,
  hintColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Roboto',
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
    // bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
    // bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
    labelLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
  ),
  cardTheme: const CardTheme(
    color: Colors.white,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.blue,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
);
