// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'events.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EventManagementAdapter extends TypeAdapter<EventManagement> {
  @override
  final int typeId = 135;

  @override
  EventManagement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EventManagement(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      planDateTo: fields[3] as DateTime,
      initDate: fields[4] as DateTime,
      initiator: fields[5] as Person,
      eventType: fields[20] as EventType,
      actualDateTo: fields[7] as DateTime,
      observer: fields[8] as Person,
      regNumber: fields[9] as String,
      sevirity: fields[10] as AbstractDictionary,
      eventDescription: fields[11] as String,
      files: (fields[12] as List)?.cast<FileDescriptor>(),
      comment: fields[13] as String,
      finishPercent: fields[14] as dynamic,
      actualDateFrom: fields[15] as DateTime,
      supportDocument: fields[24] as SupportDoc,
      supervisor: fields[17] as Person,
      planDateFrom: fields[18] as DateTime,
      status: fields[19] as AbstractDictionary,
      organization: fields[21] as Organization,
      department: fields[22] as Department,
    );
  }

  @override
  void write(BinaryWriter writer, EventManagement obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.planDateTo)
      ..writeByte(4)
      ..write(obj.initDate)
      ..writeByte(5)
      ..write(obj.initiator)
      ..writeByte(7)
      ..write(obj.actualDateTo)
      ..writeByte(8)
      ..write(obj.observer)
      ..writeByte(9)
      ..write(obj.regNumber)
      ..writeByte(10)
      ..write(obj.sevirity)
      ..writeByte(11)
      ..write(obj.eventDescription)
      ..writeByte(12)
      ..write(obj.files)
      ..writeByte(13)
      ..write(obj.comment)
      ..writeByte(14)
      ..write(obj.finishPercent)
      ..writeByte(15)
      ..write(obj.actualDateFrom)
      ..writeByte(17)
      ..write(obj.supervisor)
      ..writeByte(18)
      ..write(obj.planDateFrom)
      ..writeByte(19)
      ..write(obj.status)
      ..writeByte(20)
      ..write(obj.eventType)
      ..writeByte(21)
      ..write(obj.organization)
      ..writeByte(22)
      ..write(obj.department)
      ..writeByte(24)
      ..write(obj.supportDocument);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EventManagementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SupportDocAdapter extends TypeAdapter<SupportDoc> {
  @override
  final int typeId = 136;

  @override
  SupportDoc read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SupportDoc(
      entityName: fields[0] as String,
      id: fields[2] as String,
      instanceName: fields[1] as String,
      documentDate: fields[3] as String,
      supportDocNumber: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SupportDoc obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.documentDate)
      ..writeByte(4)
      ..write(obj.supportDocNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SupportDocAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
