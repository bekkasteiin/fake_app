// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepairOrderPojoLaborSpending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepairOrderPojoLaborSpendingAdapter
    extends TypeAdapter<RepairOrderPojoLaborSpending> {
  @override
  final int typeId = 33;

  @override
  RepairOrderPojoLaborSpending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepairOrderPojoLaborSpending(
      entityName: fields[0] as String,
      id: fields[1] as String,
      dateAndTime: fields[2] as DateTime,
      percent: fields[3] as double,
      status: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RepairOrderPojoLaborSpending obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.dateAndTime)
      ..writeByte(3)
      ..write(obj.percent)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepairOrderPojoLaborSpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
