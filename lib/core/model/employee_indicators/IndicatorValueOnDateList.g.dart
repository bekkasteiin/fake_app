// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndicatorValueOnDateList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorValueOnDateListAdapter
    extends TypeAdapter<IndicatorValueOnDateList> {
  @override
  final int typeId = 74;

  @override
  IndicatorValueOnDateList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndicatorValueOnDateList(
      entityName: fields[1] as String,
      id: fields[2] as String,
      date: fields[3] as DateTime,
      shift: fields[4] as IndicatorValueOnDateListShift,
      equipment: fields[5] as Indicator,
      indicatorValueList: (fields[6] as List)?.cast<IndicatorValueList>(),
    );
  }

  @override
  void write(BinaryWriter writer, IndicatorValueOnDateList obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.entityName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.shift)
      ..writeByte(5)
      ..write(obj.equipment)
      ..writeByte(6)
      ..write(obj.indicatorValueList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorValueOnDateListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
