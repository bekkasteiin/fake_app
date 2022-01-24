// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bsa.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BehaviorAuditAdapter extends TypeAdapter<BehaviorAudit> {
  @override
  final int typeId = 126;

  @override
  BehaviorAudit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BehaviorAudit(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      date: fields[3] as DateTime,
      regDateTime: fields[4] as DateTime,
      watchedQuantity: fields[5] as int,
      initiator: fields[6] as Person,
      empComment: fields[7] as String,
      actionDescription: fields[8] as String,
      duration: fields[9] as int,
      regNumber: fields[10] as String,
      sevirity: fields[11] as AbstractDictionary,
      organization: fields[12] as Organization,
      observations: (fields[13] as List)?.cast<Observation>(),
      objectName: fields[14] as ObjectName,
      files: (fields[15] as List)?.cast<FileDescriptor>(),
      comment: fields[16] as String,
      responsibles: (fields[17] as List)?.cast<Person>(),
      department: fields[18] as Department,
      category: fields[19] as AbstractDictionary,
      status: fields[20] as AbstractDictionary,
      workType: fields[21] as String,
      planDate: fields[22] as DateTime,
      filled: fields[23] as bool,
      isDone: fields[24] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BehaviorAudit obj) {
    writer
      ..writeByte(25)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.date)
      ..writeByte(4)
      ..write(obj.regDateTime)
      ..writeByte(5)
      ..write(obj.watchedQuantity)
      ..writeByte(6)
      ..write(obj.initiator)
      ..writeByte(7)
      ..write(obj.empComment)
      ..writeByte(8)
      ..write(obj.actionDescription)
      ..writeByte(9)
      ..write(obj.duration)
      ..writeByte(10)
      ..write(obj.regNumber)
      ..writeByte(11)
      ..write(obj.sevirity)
      ..writeByte(12)
      ..write(obj.organization)
      ..writeByte(13)
      ..write(obj.observations)
      ..writeByte(14)
      ..write(obj.objectName)
      ..writeByte(15)
      ..write(obj.files)
      ..writeByte(16)
      ..write(obj.comment)
      ..writeByte(17)
      ..write(obj.responsibles)
      ..writeByte(18)
      ..write(obj.department)
      ..writeByte(19)
      ..write(obj.category)
      ..writeByte(20)
      ..write(obj.status)
      ..writeByte(21)
      ..write(obj.workType)
      ..writeByte(22)
      ..write(obj.planDate)
      ..writeByte(23)
      ..write(obj.filled)
      ..writeByte(24)
      ..write(obj.isDone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BehaviorAuditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
