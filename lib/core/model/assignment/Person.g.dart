// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 11;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      entityName: fields[0] as String,
      id: fields[1] as String,
      birthday: fields[2] as DateTime,
      firstName: fields[3] as String,
      lastName: fields[4] as String,
      image: fields[5] as String,
      sex: fields[6] as String,
      phone: fields[11] as String,
      email: fields[12] as String,
      groupId: fields[7] as String,
      middleName: fields[8] as String,
      nationalIdentifier: fields[9] as String,
      employeeNumber: fields[10] as String,
      fullName: fields[14] as String,
      photo: fields[13] as FileDescriptor,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.birthday)
      ..writeByte(3)
      ..write(obj.firstName)
      ..writeByte(4)
      ..write(obj.lastName)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.sex)
      ..writeByte(7)
      ..write(obj.groupId)
      ..writeByte(8)
      ..write(obj.middleName)
      ..writeByte(9)
      ..write(obj.nationalIdentifier)
      ..writeByte(10)
      ..write(obj.employeeNumber)
      ..writeByte(11)
      ..write(obj.phone)
      ..writeByte(12)
      ..write(obj.email)
      ..writeByte(13)
      ..write(obj.photo)
      ..writeByte(14)
      ..write(obj.fullName);
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
