// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'risks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RisksManagementAdapter extends TypeAdapter<RisksManagement> {
  @override
  final int typeId = 128;

  @override
  RisksManagement read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RisksManagement(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      assessmentVersion: fields[3] as int,
      level: fields[4] as AbstractDictionary,
      initDate: fields[5] as DateTime,
      probability: fields[6] as AbstractDictionary,
      initiator: fields[7] as Person,
      regDate: fields[8] as DateTime,
      riskManageability: (fields[9] as List)?.cast<AbstractDictionary>(),
      dangerousCategory: fields[10] as AbstractDictionary,
      dangerousSource: fields[11] as AbstractDictionary,
      actionType: fields[12] as AbstractDictionary,
      regNumber: fields[13] as String,
      organization: fields[14] as Organization,
      objectName: fields[21] as ObjectName,
      consequences: fields[16] as AbstractDictionary,
      files: (fields[17] as List)?.cast<FileDescriptor>(),
      comment: fields[18] as String,
      department: fields[19] as Department,
      status: fields[20] as AbstractDictionary,
    );
  }

  @override
  void write(BinaryWriter writer, RisksManagement obj) {
    writer
      ..writeByte(21)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.assessmentVersion)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.initDate)
      ..writeByte(6)
      ..write(obj.probability)
      ..writeByte(7)
      ..write(obj.initiator)
      ..writeByte(8)
      ..write(obj.regDate)
      ..writeByte(9)
      ..write(obj.riskManageability)
      ..writeByte(10)
      ..write(obj.dangerousCategory)
      ..writeByte(11)
      ..write(obj.dangerousSource)
      ..writeByte(12)
      ..write(obj.actionType)
      ..writeByte(13)
      ..write(obj.regNumber)
      ..writeByte(14)
      ..write(obj.organization)
      ..writeByte(16)
      ..write(obj.consequences)
      ..writeByte(17)
      ..write(obj.files)
      ..writeByte(18)
      ..write(obj.comment)
      ..writeByte(19)
      ..write(obj.department)
      ..writeByte(20)
      ..write(obj.status)
      ..writeByte(21)
      ..write(obj.objectName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RisksManagementAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
