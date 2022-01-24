// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShiftDetail.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftDetailAdapter extends TypeAdapter<ShiftDetail> {
  @override
  final int typeId = 76;

  @override
  ShiftDetail read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftDetail(
      entityName: fields[0] as String,
      id: fields[1] as String,
      hours: fields[2] as double,
      isNight: fields[3] as bool,
      shift: fields[4] as ShiftDetailShift,
      dayOrder: fields[5] as int,
      version: fields[6] as int,
      startTime: fields[7] as String,
      endTime: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftDetail obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.hours)
      ..writeByte(3)
      ..write(obj.isNight)
      ..writeByte(4)
      ..write(obj.shift)
      ..writeByte(5)
      ..write(obj.dayOrder)
      ..writeByte(6)
      ..write(obj.version)
      ..writeByte(7)
      ..write(obj.startTime)
      ..writeByte(8)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftDetailAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
