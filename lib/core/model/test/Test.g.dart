// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Test.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestAdapter extends TypeAdapter<Test> {
  @override
  final int typeId = 59;

  @override
  Test read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Test(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      result: fields[3] as double,
      duration: fields[4] as int,
      answers: (fields[5] as List)?.cast<Answer>(),
      testDate: fields[6] as DateTime,
      startTime: fields[7] as DateTime,
      endTime: fields[8] as DateTime,
      timeForQuestion: fields[9] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Test obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.result)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.answers)
      ..writeByte(6)
      ..write(obj.testDate)
      ..writeByte(7)
      ..write(obj.startTime)
      ..writeByte(8)
      ..write(obj.endTime)
      ..writeByte(9)
      ..write(obj.timeForQuestion);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
