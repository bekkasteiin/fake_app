// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepairOrderPojoWork.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepairOrderPojoWorkAdapter extends TypeAdapter<RepairOrderPojoWork> {
  @override
  final int typeId = 34;

  @override
  RepairOrderPojoWork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepairOrderPojoWork(
      entityName: fields[0] as String,
      id: fields[1] as String,
      defect: (fields[2] as List)?.cast<Defect>(),
      material: (fields[3] as List)?.cast<Material>(),
      repairClass: fields[4] as String,
      person: (fields[5] as List)?.cast<Person>(),
    );
  }

  @override
  void write(BinaryWriter writer, RepairOrderPojoWork obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.defect)
      ..writeByte(3)
      ..write(obj.material)
      ..writeByte(4)
      ..write(obj.repairClass)
      ..writeByte(5)
      ..write(obj.person);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepairOrderPojoWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
