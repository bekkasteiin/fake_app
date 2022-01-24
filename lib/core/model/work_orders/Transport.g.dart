// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transport.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportAdapter extends TypeAdapter<Transport> {
  @override
  final int typeId = 46;

  @override
  Transport read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Transport(
      entityName: fields[0] as String,
      id: fields[1] as String,
      trip: fields[2] as double,
      plan: fields[3] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Transport obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.trip)
      ..writeByte(3)
      ..write(obj.plan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
