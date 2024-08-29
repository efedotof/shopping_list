// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListBoxAdapter extends TypeAdapter<ListBox> {
  @override
  final int typeId = 0;

  @override
  ListBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListBox(
      name: fields[0] as String,
      itemsList: (fields[1] as List).cast<String>(),
      itemsBoolList: (fields[2] as List).cast<bool>(),
      itemsIntList: (fields[3] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.itemsList)
      ..writeByte(2)
      ..write(obj.itemsBoolList)
      ..writeByte(3)
      ..write(obj.itemsIntList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
