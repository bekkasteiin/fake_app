// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Department.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DepartmentAdapter extends TypeAdapter<Department> {
  @override
  final int typeId = 8;

  @override
  Department read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Department(
      entityName: fields[0] as String,
      id: fields[1] as String,
      departmentName: fields[2] as String,
      groupId: fields[3] as String,
      employees: (fields[5] as List)?.cast<Person>(),
      objectName: (fields[4] as List)?.cast<ObjectName>(),
    );
  }

  @override
  void write(BinaryWriter writer, Department obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.departmentName)
      ..writeByte(3)
      ..write(obj.groupId)
      ..writeByte(4)
      ..write(obj.objectName)
      ..writeByte(5)
      ..write(obj.employees);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DepartmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
