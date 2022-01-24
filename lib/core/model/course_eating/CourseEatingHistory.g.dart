// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CourseEatingHistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseEatingHistoryAdapter extends TypeAdapter<CourseEatingHistory> {
  @override
  final int typeId = 16;

  @override
  CourseEatingHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseEatingHistory(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      assessment: fields[3] as double,
      courseEatingDate: fields[4] as DateTime,
      location: fields[5] as String,
      dishes: (fields[7] as List)?.cast<Dish>(),
      amount: fields[6] as double,
      locationGroup: fields[8] as String,
      dayLimitOverrun: fields[9] as double,
    );
  }

  @override
  void write(BinaryWriter writer, CourseEatingHistory obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.assessment)
      ..writeByte(4)
      ..write(obj.courseEatingDate)
      ..writeByte(5)
      ..write(obj.location)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.dishes)
      ..writeByte(8)
      ..write(obj.locationGroup)
      ..writeByte(9)
      ..write(obj.dayLimitOverrun);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CourseEatingHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
