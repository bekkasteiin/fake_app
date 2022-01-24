// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'IndicatorValueList.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorValueListAdapter extends TypeAdapter<IndicatorValueList> {
  @override
  final int typeId = 73;

  @override
  IndicatorValueList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IndicatorValueList(
      entityName: fields[1] as String,
      id: fields[2] as String,
      indicator: fields[3] as Indicator,
      uom: fields[4] as Uom,
      indicatorValue: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, IndicatorValueList obj) {
    writer
      ..writeByte(5)
      ..writeByte(1)
      ..write(obj.entityName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.indicator)
      ..writeByte(4)
      ..write(obj.uom)
      ..writeByte(5)
      ..write(obj.indicatorValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorValueListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
