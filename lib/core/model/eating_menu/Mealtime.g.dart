// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Mealtime.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealtimeAdapter extends TypeAdapter<Mealtime> {
  @override
  final int typeId = 68;

  @override
  Mealtime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Mealtime(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      langValue1: fields[3] as String,
      startTime: fields[4] as String,
      endTime: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Mealtime obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.langValue1)
      ..writeByte(4)
      ..write(obj.startTime)
      ..writeByte(5)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealtimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
