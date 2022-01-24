// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Place.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaceAdapter extends TypeAdapter<Place> {
  @override
  final int typeId = 51;

  @override
  Place read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Place(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      groupName: fields[3] as String,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Place obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.groupName)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
