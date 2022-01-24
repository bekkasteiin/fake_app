// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Organization.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrganizationAdapter extends TypeAdapter<Organization> {
  @override
  final int typeId = 10;

  @override
  Organization read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Organization(
      entityName: fields[0] as String,
      id: fields[1] as String,
      organizationName: fields[2] as String,
      groupId: fields[3] as String,
      orgAddress: fields[4] as String,
      departments: (fields[5] as List)?.cast<Department>(),
    );
  }

  @override
  void write(BinaryWriter writer, Organization obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.organizationName)
      ..writeByte(3)
      ..write(obj.groupId)
      ..writeByte(4)
      ..write(obj.orgAddress)
      ..writeByte(5)
      ..write(obj.departments);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrganizationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
