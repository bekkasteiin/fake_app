// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkOrderShiftWork.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderShiftWorkAdapter extends TypeAdapter<WorkOrderShiftWork> {
  @override
  final int typeId = 45;

  @override
  WorkOrderShiftWork read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderShiftWork(
      entityName: fields[0] as String,
      id: fields[1] as String,
      uom: fields[2] as String,
      plan: fields[10] as double,
      laborSpending: (fields[3] as List)?.cast<WorkLaborSpending>(),
      production: fields[4] as String,
      work: fields[5] as bool,
      person: (fields[6] as List)?.cast<Person>(),
      workType: fields[7] as String,
      equipment: fields[8] as String,
      operationType: fields[12] as String,
      comment: fields[9] as String,
      transport: fields[11] as Transport,
      workPlace: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderShiftWork obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.uom)
      ..writeByte(3)
      ..write(obj.laborSpending)
      ..writeByte(4)
      ..write(obj.production)
      ..writeByte(5)
      ..write(obj.work)
      ..writeByte(6)
      ..write(obj.person)
      ..writeByte(7)
      ..write(obj.workType)
      ..writeByte(8)
      ..write(obj.equipment)
      ..writeByte(9)
      ..write(obj.comment)
      ..writeByte(10)
      ..write(obj.plan)
      ..writeByte(11)
      ..write(obj.transport)
      ..writeByte(12)
      ..write(obj.operationType)
      ..writeByte(13)
      ..write(obj.workPlace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderShiftWorkAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
