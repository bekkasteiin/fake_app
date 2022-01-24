// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Ppe.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PpeAdapter extends TypeAdapter<Ppe> {
  @override
  final int typeId = 7;

  @override
  Ppe read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ppe(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      image: fields[3] as String,
      overNorm: fields[4] as bool,
      langValue: fields[5] as String,
      description: fields[6] as String,
      perscentWear: fields[7] as double,
      size: fields[8] as String,
      endDate: fields[9] as DateTime,
      seasonSign: fields[10] as String,
      issueDate: fields[11] as DateTime,
      sizeGrowth: fields[12] as String,
      watchDate: fields[13] as DateTime,
      actualCost: fields[14] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Ppe obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.image)
      ..writeByte(4)
      ..write(obj.overNorm)
      ..writeByte(5)
      ..write(obj.langValue)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.perscentWear)
      ..writeByte(8)
      ..write(obj.size)
      ..writeByte(9)
      ..write(obj.endDate)
      ..writeByte(10)
      ..write(obj.seasonSign)
      ..writeByte(11)
      ..write(obj.issueDate)
      ..writeByte(12)
      ..write(obj.sizeGrowth)
      ..writeByte(13)
      ..write(obj.watchDate)
      ..writeByte(14)
      ..write(obj.actualCost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PpeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
