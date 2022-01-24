// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonalProtectionEquipment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonalProtectionEquipmentAdapter
    extends TypeAdapter<PersonalProtectionEquipment> {
  @override
  final int typeId = 6;

  @override
  PersonalProtectionEquipment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonalProtectionEquipment(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      perscent: fields[3] as String,
      ppes: (fields[4] as List)?.cast<Ppe>(),
    );
  }

  @override
  void write(BinaryWriter writer, PersonalProtectionEquipment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.perscent)
      ..writeByte(4)
      ..write(obj.ppes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonalProtectionEquipmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
