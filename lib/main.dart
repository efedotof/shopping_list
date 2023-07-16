import 'package:flutter/material.dart';
import 'package:spisok_pokupok/screen/home.dart';
import 'package:spisok_pokupok/screen/splashScreen.dart';

void main() => runApp(MaterialApp(
      
      theme: ThemeData(
        primaryColor: const Color.fromARGB(
            244, 255, 255, 255), // Основной цвет приложения
        hintColor: Colors
            .blueGrey, // Дополнительный цвет для подчеркивания важных элементов
        scaffoldBackgroundColor: Colors.white, // Цвет фона Scaffold
        fontFamily: 'Roboto', // Шрифт по умолчанию для текста
        textTheme: const TextTheme(
          // ignore: deprecated_member_use
          headline1: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold), // Заголовок первого уровня
          // ignore: deprecated_member_use
          headline2: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500), // Заголовок второго уровня
          // ignore: deprecated_member_use
          bodyText1:
              TextStyle(fontSize: 16, color: Colors.black87), // Обычный текст
          // ignore: deprecated_member_use
          button: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.white, // Цвет AppBar
          elevation: 0, // Высота тени под AppBar
          iconTheme: IconThemeData(color: Colors.black), // Цвет иконок AppBar
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.blue, // Основной цвет кнопок
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8)), // Форма кнопок
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 8), // Отступы внутри кнопок
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const splashScreens(),
      },
      debugShowCheckedModeBanner: false,
    ));
