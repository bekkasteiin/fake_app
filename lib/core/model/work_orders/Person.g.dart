// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 37;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      entityName: fields[0] as String,
      id: fields[1] as String,
      lastName: fields[3] as String,
      groupId: fields[5] as String,
      firstName: fields[2] as String,
      stateNumber: fields[6] as String,
      image: fields[4] as String,
      middleName: fields[7] as String,
      equipmentName: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(9)
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
      ..write(obj.groupId)
      ..writeByte(6)
      ..write(obj.stateNumber)
      ..writeByte(7)
      ..write(obj.middleName)
      ..writeByte(8)
      ..write(obj.equipmentName);
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
