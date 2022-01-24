// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventEntityAdapter extends TypeAdapter<EventEntity> {
  @override
  final int typeId = 133;

  @override
  EventEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventEntity(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      issuedTo: fields[3] as Person,
      initDate: fields[4] as DateTime,
      initiator: fields[5] as Person,
      eventType: fields[6] as EventType,
      regNumber: fields[7] as String,
      comment: fields[8] as String,
      commentNid: fields[10] as String,
      nationalId: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventEntity obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.issuedTo)
      ..writeByte(4)
      ..write(obj.initDate)
      ..writeByte(5)
      ..write(obj.initiator)
      ..writeByte(6)
      ..write(obj.eventType)
      ..writeByte(7)
      ..write(obj.regNumber)
      ..writeByte(8)
      ..write(obj.comment)
      ..writeByte(9)
      ..write(obj.nationalId)
      ..writeByte(10)
      ..write(obj.commentNid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class EventTypeAdapter extends TypeAdapter<EventType> {
  @override
  final int typeId = 134;

  @override
  EventType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventType(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      color: fields[4] as String,
      langValue: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EventType obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.langValue);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
