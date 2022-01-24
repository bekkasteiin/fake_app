// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GroupAccess.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GroupAccessAdapter extends TypeAdapter<GroupAccess> {
  @override
  final int typeId = 5;

  @override
  GroupAccess read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GroupAccess(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, GroupAccess obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GroupAccessAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
