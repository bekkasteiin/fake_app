// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TicketAdapter extends TypeAdapter<Ticket> {
  @override
  final int typeId = 131;

  @override
  Ticket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ticket(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      issuedDate: fields[3] as DateTime,
      qr: fields[4] as String,
      ticketNumber: fields[5] as String,
      code: fields[6] as String,
      issuedBy: fields[7] as Person,
      type: fields[8] as String,
      incident: fields[9] as String,
      status: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ticket obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.issuedDate)
      ..writeByte(4)
      ..write(obj.qr)
      ..writeByte(5)
      ..write(obj.ticketNumber)
      ..writeByte(6)
      ..write(obj.code)
      ..writeByte(7)
      ..write(obj.issuedBy)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.incident)
      ..writeByte(10)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TicketResponseAdapter extends TypeAdapter<TicketResponse> {
  @override
  final int typeId = 130;

  @override
  TicketResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TicketResponse(
      ticket: fields[0] as Ticket,
      status: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TicketResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.ticket)
      ..writeByte(1)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TicketResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
