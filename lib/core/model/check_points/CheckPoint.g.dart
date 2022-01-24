// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CheckPoint.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CheckPointAdapter extends TypeAdapter<CheckPoint> {
  @override
  final int typeId = 15;

  @override
  CheckPoint read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CheckPoint(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      dateAndTime: fields[3] as DateTime,
      controlPoint: fields[4] as String,
      direction: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CheckPoint obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.dateAndTime)
      ..writeByte(4)
      ..write(obj.controlPoint)
      ..writeByte(5)
      ..write(obj.direction);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CheckPointAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
