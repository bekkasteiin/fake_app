// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Vehicle.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleAdapter extends TypeAdapter<Vehicle> {
  @override
  final int typeId = 14;

  @override
  Vehicle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Vehicle(
      entityName: fields[0] as String,
      id: fields[1] as String,
      marc: fields[2] as String,
      stateNumber: fields[3] as String,
      model: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Vehicle obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.marc)
      ..writeByte(3)
      ..write(obj.stateNumber)
      ..writeByte(4)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
