// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonPojoAdapter extends TypeAdapter<PersonPojo> {
  @override
  final int typeId = 30;

  @override
  PersonPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PersonPojo(
      entityName: fields[0] as String,
      id: fields[1] as String,
      firstName: fields[2] as String,
      lastName: fields[3] as String,
      image: fields[4] as String,
      middleName: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PersonPojo obj) {
    writer
      ..writeByte(6)
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
      ..write(obj.middleName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
