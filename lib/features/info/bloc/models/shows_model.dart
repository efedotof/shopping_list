import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../../../localStorage/LisBoxses/list_box.dart';

class ShowCardsProvider with ChangeNotifier {
  List<bool> elementBool;
  List<int> elementint;
  List<String> elementTitle;
  late Box<ListBox> listBox;
  final int targetIndex;

  ShowCardsProvider({
    required this.elementBool,
    required this.elementint,
    required this.elementTitle,
    required this.targetIndex,
  }) {
    _initializeHive();
  }

  Future<void> _initializeHive() async {
    listBox = await Hive.openBox<ListBox>('listbox');
    var listBoxData = listBox.getAt(targetIndex);

    if (listBoxData != null) {
      elementBool = List.from(listBoxData.itemsBoolList);
      elementTitle = List.from(listBoxData.itemsList);
      elementint = List.from(listBoxData.itemsIntList);

      if (elementBool.length != elementint.length || elementint.length != elementTitle.length) {
        elementBool = [];
        elementint = [];
        elementTitle = [];
      }
    } else {
      var newListBox = ListBox(
        itemsList: elementTitle,
        itemsBoolList: elementBool,
        itemsIntList: elementint,
      );
      await listBox.putAt(targetIndex, newListBox);
    }

    notifyListeners();
  }

  void changeBool(int index) {
    if (index < elementBool.length) {
      elementBool[index] = !elementBool[index];
      saveChanges();
      notifyListeners();
    }
  }

  void saveChanges() {
    var listBoxData = listBox.getAt(targetIndex);

    if (listBoxData != null) {      listBoxData.itemsBoolList = List.from(elementBool);
      listBoxData.itemsList = List.from(elementTitle);
      listBoxData.itemsIntList = List.from(elementint);
      listBox.putAt(targetIndex, listBoxData);
    }
  }
}
