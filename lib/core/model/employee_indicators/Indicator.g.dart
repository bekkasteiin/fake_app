// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Indicator.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IndicatorAdapter extends TypeAdapter<Indicator> {
  @override
  final int typeId = 72;

  @override
  Indicator read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Indicator(
      entityName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      isSystemRecord: fields[4] as bool,
      langValue: fields[5] as String,
      version: fields[6] as int,
      langValue1: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Indicator obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.entityName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.isSystemRecord)
      ..writeByte(5)
      ..write(obj.langValue)
      ..writeByte(6)
      ..write(obj.version)
      ..writeByte(7)
      ..write(obj.langValue1);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IndicatorAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
