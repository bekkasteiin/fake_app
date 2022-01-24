// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Driver.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DriverAdapter extends TypeAdapter<Driver> {
  @override
  final int typeId = 13;

  @override
  Driver read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Driver(
      entityName: fields[0] as String,
      id: fields[1] as String,
      contact: fields[2] as String,
      fullName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Driver obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.contact)
      ..writeByte(3)
      ..write(obj.fullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DriverAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
