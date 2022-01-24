// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appeals.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppealsAdapter extends TypeAdapter<Appeals> {
  @override
  final int typeId = 2;

  @override
  Appeals read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Appeals(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      decision: fields[4] as String,
      description: fields[5] as String,
      topic: fields[6] as String,
      type: fields[7] as String,
      appealLocalDateTime: fields[8] as DateTime,
      status: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Appeals obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.decision)
      ..writeByte(5)
      ..write(obj.description)
      ..writeByte(6)
      ..write(obj.topic)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.appealLocalDateTime)
      ..writeByte(9)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppealsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
