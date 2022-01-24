// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ShiftDetailShift.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShiftDetailShiftAdapter extends TypeAdapter<ShiftDetailShift> {
  @override
  final int typeId = 78;

  @override
  ShiftDetailShift read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShiftDetailShift(
      entityName: fields[0] as String,
      id: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ShiftDetailShift obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShiftDetailShiftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
