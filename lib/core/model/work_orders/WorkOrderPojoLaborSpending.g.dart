// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkOrderPojoLaborSpending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderPojoLaborSpendingAdapter
    extends TypeAdapter<WorkOrderPojoLaborSpending> {
  @override
  final int typeId = 42;

  @override
  WorkOrderPojoLaborSpending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderPojoLaborSpending(
      entityName: fields[0] as String,
      id: fields[1] as String,
      factObject: fields[2] as double,
      factEndDate: fields[3] as DateTime,
      percentCompletion: fields[4] as double,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderPojoLaborSpending obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.factObject)
      ..writeByte(3)
      ..write(obj.factEndDate)
      ..writeByte(4)
      ..write(obj.percentCompletion)
      ..writeByte(5)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderPojoLaborSpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
