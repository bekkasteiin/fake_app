// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FoodLimits.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FoodLimitsAdapter extends TypeAdapter<FoodLimits> {
  @override
  final int typeId = 70;

  @override
  FoodLimits read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FoodLimits(
      monthLimit: fields[0] as num,
      dayLimit: fields[1] as num,
      spent: fields[2] as num,
      left: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, FoodLimits obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.monthLimit)
      ..writeByte(1)
      ..write(obj.dayLimit)
      ..writeByte(2)
      ..write(obj.spent)
      ..writeByte(3)
      ..write(obj.left);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FoodLimitsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
