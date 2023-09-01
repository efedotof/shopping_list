

import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spisok_pokupok/intil.dart';
import 'package:spisok_pokupok/widget/message.dart';

class Auth{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> create(
  BuildContext context,
  List<String> name,
  List<String> spisok,
  String id,
) async {
  try {
    if (name.isNotEmpty && spisok.isNotEmpty) {
      CollectionReference adminPanelCollection = firestore.collection('users');
      DocumentSnapshot docSnapshot = await adminPanelCollection.doc(id).get();

      List<String> shop = [];
      List<String> list = [];

      if (docSnapshot.exists) {
        Map<String, dynamic> data = docSnapshot.data() as Map<String, dynamic>;

        shop = List<String>.from(data['shoppingList'] ?? []);
        list = List<String>.from(data['titleList'] ?? []);
      }

      // Добавление только новых элементов
      for (String newItem in spisok) {
        if (!shop.contains(newItem)) {
          shop.add(newItem);
        }
      }

      for (String newItem in name) {
        if (!list.contains(newItem)) {
          list.add(newItem);
        }
      }

      await adminPanelCollection.doc(id).set({
        'shoppingList': shop,
        'titleList': list,
      });

      // Очистка временных списков
      shop = [];
      list = [];
    }
  } catch (e) {
    // Обработка ошибок, например, вывод ошибки в консоль
    if (kDebugMode) {
      print('Error: $e');
    }
  }
}
Future<void> fetchShoppingAndTitleLists(BuildContext context, String userId) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userSnapshot.exists) {
      List<dynamic>? shoppingList = userSnapshot.data()?['shoppingList'];
      List<dynamic>? titleList = userSnapshot.data()?['titleList'];

      if (shoppingList != null && titleList != null) {
        if (shoppingList.isNotEmpty && titleList.isNotEmpty) {
          keyshoppingList.addAll(shoppingList.map((item) => item.toString()));
          if (kDebugMode) {
            print('Shopping List: $shoppingList');
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Данные получены')),
          );
          keytitleStringList.addAll(titleList.map((item) => item.toString()));
          if (kDebugMode) {
            print('Title List: $titleList');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Списки пусты')),
          );
          if (kDebugMode) {
            print('Списки пусты');
          }
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Списки отсутствуют')),
        );
        if (kDebugMode) {
          print('Списки отсутствуют');
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Пользователь не найден')),
      );
      if (kDebugMode) {
        print('Пользователь не найден');
      }
    }
 } catch (error) {
  String errorMessage = 'Произошла ошибка при получении данных';
  
  if (error is SocketException) {
    errorMessage = 'Нет подключения к интернету. Пожалуйста, проверьте ваше подключение.';
  } else if (error is TimeoutException) {
    errorMessage = 'Время ожидания истекло. Пожалуйста, попробуйте позже.';
  }
  
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(errorMessage)),
  );
  
  if (kDebugMode) {
    print(errorMessage);
  }
}
}
}
