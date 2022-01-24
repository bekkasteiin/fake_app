// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CarOrderGroupped.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarOrderGrouppedAdapter extends TypeAdapter<CarOrderGroupped> {
  @override
  final int typeId = 65;

  @override
  CarOrderGroupped read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarOrderGroupped(
      instanceName: fields[0] as String,
      id: fields[1] as String,
      month: fields[2] as String,
      list: (fields[3] as List)?.cast<CarOrder>(),
    );
  }

  @override
  void write(BinaryWriter writer, CarOrderGroupped obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.instanceName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.month)
      ..writeByte(3)
      ..write(obj.list);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarOrderGrouppedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
