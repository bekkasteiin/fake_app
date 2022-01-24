// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_name.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ObjectNameAdapter extends TypeAdapter<ObjectName> {
  @override
  final int typeId = 125;

  @override
  ObjectName read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ObjectName(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      langValue: fields[4] as String,
      department: fields[5] as Department,
    );
  }

  @override
  void write(BinaryWriter writer, ObjectName obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.langValue)
      ..writeByte(5)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ObjectNameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
