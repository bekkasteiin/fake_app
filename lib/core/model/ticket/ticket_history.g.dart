// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketHistoryAdapter extends TypeAdapter<TicketHistory> {
  @override
  final int typeId = 132;

  @override
  TicketHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketHistory(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      ticketNumber: fields[3] as String,
      color: fields[4] as String,
      issuedBy: fields[5] as Person,
      type: fields[6] as String,
      actionDate: fields[7] as DateTime,
      incident: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TicketHistory obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.ticketNumber)
      ..writeByte(4)
      ..write(obj.color)
      ..writeByte(5)
      ..write(obj.issuedBy)
      ..writeByte(6)
      ..write(obj.type)
      ..writeByte(7)
      ..write(obj.actionDate)
      ..writeByte(8)
      ..write(obj.incident);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
