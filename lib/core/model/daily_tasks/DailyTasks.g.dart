// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DailyTasks.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyTasksAdapter extends TypeAdapter<DailyTasks> {
  @override
  final int typeId = 18;

  @override
  DailyTasks read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyTasks(
      id: fields[0] as String,
      date: fields[1] as DateTime,
      equipment: fields[2] as String,
      worksType: fields[3] as String,
      worksPlan: fields[4] as String,
      worksFact: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DailyTasks obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.date)
      ..writeByte(2)
      ..write(obj.equipment)
      ..writeByte(3)
      ..write(obj.worksType)
      ..writeByte(4)
      ..write(obj.worksPlan)
      ..writeByte(5)
      ..write(obj.worksFact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyTasksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
