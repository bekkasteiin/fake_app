// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndicatorValueOndateListShift.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorValueOnDateListShiftAdapter
    extends TypeAdapter<IndicatorValueOnDateListShift> {
  @override
  final int typeId = 77;

  @override
  IndicatorValueOnDateListShift read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndicatorValueOnDateListShift(
      entityName: fields[0] as String,
      id: fields[1] as String,
      version: fields[2] as int,
      shiftDetail: (fields[3] as List)?.cast<ShiftDetail>(),
      name: fields[4] as String,
      startTime: fields[5] as String,
      endTime: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, IndicatorValueOnDateListShift obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.version)
      ..writeByte(3)
      ..write(obj.shiftDetail)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.startTime)
      ..writeByte(6)
      ..write(obj.endTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorValueOnDateListShiftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
