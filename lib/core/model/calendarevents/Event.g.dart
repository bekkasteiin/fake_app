// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventAdapter extends TypeAdapter<Event> {
  @override
  final int typeId = 67;

  @override
  Event read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Event(
      entityName: fields[0] as String,
      id: fields[1] as String,
      endDate: fields[2] as DateTime,
      description: fields[3] as String,
      title: fields[4] as String,
      ppeName: fields[5] as String,
      typeCode: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Event obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.endDate)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.title)
      ..writeByte(5)
      ..write(obj.ppeName)
      ..writeByte(6)
      ..write(obj.typeCode);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
