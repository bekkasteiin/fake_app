// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MaterialObligations.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialObligationsAdapter extends TypeAdapter<MaterialObligations> {
  @override
  final int typeId = 24;

  @override
  MaterialObligations read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MaterialObligations(
      entityName: fields[0] as String,
      id: fields[1] as String,
      totalAmount: fields[2] as double,
      total: fields[3] as double,
      ppes: (fields[4] as List)?.cast<Ppe>(),
      items: (fields[5] as List)?.cast<Item>(),
      tools: (fields[6] as List)?.cast<Item>(),
    );
  }

  @override
  void write(BinaryWriter writer, MaterialObligations obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.totalAmount)
      ..writeByte(3)
      ..write(obj.total)
      ..writeByte(4)
      ..write(obj.ppes)
      ..writeByte(5)
      ..write(obj.items)
      ..writeByte(6)
      ..write(obj.tools);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialObligationsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
