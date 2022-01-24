// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CalendarEvents.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CalendarEventsAdapter extends TypeAdapter<CalendarEvents> {
  @override
  final int typeId = 4;

  @override
  CalendarEvents read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalendarEvents(
      date: fields[1] as DateTime,
      events: (fields[2] as List)?.cast<Event>(),
      id: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CalendarEvents obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.events);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarEventsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
