// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 121;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      regDateTime: fields[3] as DateTime,
      initiator: fields[4] as Person,
      dangerousConditionCategories:
          (fields[5] as List)?.cast<ConditionCategory>(),
      violatedEmployees: (fields[6] as List)?.cast<Person>(),
      initiatorPrivacy: fields[7] as bool,
      requestNumber: fields[8] as String,
      initDateTime: fields[9] as DateTime,
      sevirity: fields[10] as AbstractDictionary,
      otherViolationComment: fields[11] as String,
      organization: fields[12] as Organization,
      objectName: fields[13] as ObjectName,
      files: (fields[14] as List)?.cast<FileDescriptor>(),
      comment: fields[15] as String,
      takenAction: fields[16] as AbstractDictionary,
      category: fields[17] as AbstractDictionary,
      department: fields[18] as Department,
      dangerousActions: (fields[19] as List)?.cast<AbstractDictionary>(),
      status: fields[20] as AbstractDictionary,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.regDateTime)
      ..writeByte(4)
      ..write(obj.initiator)
      ..writeByte(5)
      ..write(obj.dangerousConditionCategories)
      ..writeByte(6)
      ..write(obj.violatedEmployees)
      ..writeByte(7)
      ..write(obj.initiatorPrivacy)
      ..writeByte(8)
      ..write(obj.requestNumber)
      ..writeByte(9)
      ..write(obj.initDateTime)
      ..writeByte(10)
      ..write(obj.sevirity)
      ..writeByte(11)
      ..write(obj.otherViolationComment)
      ..writeByte(12)
      ..write(obj.organization)
      ..writeByte(13)
      ..write(obj.objectName)
      ..writeByte(14)
      ..write(obj.files)
      ..writeByte(15)
      ..write(obj.comment)
      ..writeByte(16)
      ..write(obj.takenAction)
      ..writeByte(17)
      ..write(obj.category)
      ..writeByte(18)
      ..write(obj.department)
      ..writeByte(19)
      ..write(obj.dangerousActions)
      ..writeByte(20)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
