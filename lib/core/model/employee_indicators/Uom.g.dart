// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Uom.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UomAdapter extends TypeAdapter<Uom> {
  @override
  final int typeId = 75;

  @override
  Uom read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Uom(
      entityName: fields[0] as String,
      id: fields[1] as String,
      code: fields[2] as String,
      description: fields[3] as String,
      description2: fields[4] as String,
      description1: fields[5] as String,
      isSystemRecord: fields[6] as bool,
      langValue: fields[7] as String,
      version: fields[8] as int,
      langValue1: fields[9] as String,
      langValue2: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Uom obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.description2)
      ..writeByte(5)
      ..write(obj.description1)
      ..writeByte(6)
      ..write(obj.isSystemRecord)
      ..writeByte(7)
      ..write(obj.langValue)
      ..writeByte(8)
      ..write(obj.version)
      ..writeByte(9)
      ..write(obj.langValue1)
      ..writeByte(10)
      ..write(obj.langValue2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UomAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
