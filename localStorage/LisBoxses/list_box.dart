import 'package:hive/hive.dart';

part 'list_box.g.dart';

@HiveType(typeId: 0)
class ListBox {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late List<String> itemsList;
  @HiveField(2)
  late List<bool> itemsBoolList;
  @HiveField(3)
  late List<int> itemsIntList;

  ListBox({
    this.name = '',
    required this.itemsList,
    required this.itemsBoolList,
    required this.itemsIntList,
  });

  copyWith({required List<bool> itemsBoolList}) {}
}
