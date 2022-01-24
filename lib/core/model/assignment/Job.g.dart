// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Job.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobAdapter extends TypeAdapter<Job> {
  @override
  final int typeId = 9;

  @override
  Job read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Job(
      entityName: fields[0] as String,
      id: fields[1] as String,
      jobName: fields[2] as String,
      code: fields[3] as String,
      groupId: fields[4] as String,
      aup: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Job obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.jobName)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.groupId)
      ..writeByte(5)
      ..write(obj.aup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
