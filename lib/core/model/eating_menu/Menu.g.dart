// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Menu.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenuAdapter extends TypeAdapter<Menu> {
  @override
  final int typeId = 21;

  @override
  Menu read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Menu(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Menu obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenuAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
