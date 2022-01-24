// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Placement.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlacementAdapter extends TypeAdapter<Placement> {
  @override
  final int typeId = 52;

  @override
  Placement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Placement(
      entityName: fields[0] as String,
      id: fields[1] as String,
      endDate: fields[2] as DateTime,
      hotel: fields[3] as String,
      location: fields[4] as String,
      room: fields[5] as String,
      startDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Placement obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.hotel)
      ..writeByte(4)
      ..write(obj.location)
      ..writeByte(5)
      ..write(obj.room)
      ..writeByte(6)
      ..write(obj.startDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlacementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
