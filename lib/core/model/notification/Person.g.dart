// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 50;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      entityName: fields[0] as String,
      id: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      image: fields[4] as String,
      organization: fields[5] as String,
      middleName: fields[6] as String,
      department: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.firstName)
      ..writeByte(3)
      ..write(obj.lastName)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.organization)
      ..writeByte(6)
      ..write(obj.middleName)
      ..writeByte(7)
      ..write(obj.department);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
