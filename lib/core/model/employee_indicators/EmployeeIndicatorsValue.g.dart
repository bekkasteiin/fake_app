// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EmployeeIndicatorsValue.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EmployeeIndicatorsValueAdapter
    extends TypeAdapter<EmployeeIndicatorsValue> {
  @override
  final int typeId = 71;

  @override
  EmployeeIndicatorsValue read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EmployeeIndicatorsValue(
      entityName: fields[1] as String,
      id: fields[2] as String,
      indicatorValueOnDateList:
          (fields[3] as List)?.cast<IndicatorValueOnDateList>(),
      shiftNameRu: fields[4] as String,
      indicatorTotalValueList: (fields[5] as List)?.cast<IndicatorValueList>(),
      shiftNameEn: fields[6] as String,
      shiftNameKz: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EmployeeIndicatorsValue obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.entityName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.indicatorValueOnDateList)
      ..writeByte(4)
      ..write(obj.shiftNameRu)
      ..writeByte(5)
      ..write(obj.indicatorTotalValueList)
      ..writeByte(6)
      ..write(obj.shiftNameEn)
      ..writeByte(7)
      ..write(obj.shiftNameKz);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EmployeeIndicatorsValueAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
