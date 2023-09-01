
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spisok_pokupok/screen/splashScreen.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int savedRandomNumber = 0;
  if(prefs.getInt('randomNumber') == null){
    savedRandomNumber = generateRandomNumber();
    prefs.setInt('randomNumber', savedRandomNumber);
    //firebase create database collection users -> document savedRandomNumber -> array first shoppingList second titleList
    await FirebaseFirestore.instance.collection('users').doc(savedRandomNumber.toString()).set({
      'shoppingList': [],
      'titleList': [],
      
    });
  }else{
    savedRandomNumber = prefs.getInt('randomNumber')!;
  }
  // Получение сохраненного случайного числа
  runApp(MaterialApp(
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
        '/': (context) =>  splashScreens(uniqKey: savedRandomNumber.toString(),),
      },
      debugShowCheckedModeBanner: false,
    ));
}
int generateRandomNumber() {
  Random random = Random();
  return random.nextInt(1000000); // Генерация случайного числа от 0 до 99
}









