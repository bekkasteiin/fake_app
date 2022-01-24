// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkOrderPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderPojoAdapter extends TypeAdapter<WorkOrderPojo> {
  @override
  final int typeId = 41;

  @override
  WorkOrderPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderPojo(
      entityName: fields[0] as String,
      id: fields[1] as String,
      totalFact: fields[2] as double,
      production: fields[3] as String,
      plannedVolume: fields[4] as double,
      shift: fields[5] as String,
      personPojo: (fields[6] as List)?.cast<Person>(),
      plannedEndDate: fields[7] as DateTime,
      listOfEquipmentUsed: (fields[8] as List)?.cast<ListOfEquipmentUsed>(),
      number: fields[9] as String,
      uom: fields[10] as String,
      laborSpending: (fields[11] as List)?.cast<WorkOrderPojoLaborSpending>(),
      workType: fields[12] as String,
      comment: fields[13] as String,
      workOrderId: fields[14] as String,
      totalPercent: fields[15] as double,
      workplace: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderPojo obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.totalFact)
      ..writeByte(3)
      ..write(obj.production)
      ..writeByte(4)
      ..write(obj.plannedVolume)
      ..writeByte(5)
      ..write(obj.shift)
      ..writeByte(6)
      ..write(obj.personPojo)
      ..writeByte(7)
      ..write(obj.plannedEndDate)
      ..writeByte(8)
      ..write(obj.listOfEquipmentUsed)
      ..writeByte(9)
      ..write(obj.number)
      ..writeByte(10)
      ..write(obj.uom)
      ..writeByte(11)
      ..write(obj.laborSpending)
      ..writeByte(12)
      ..write(obj.workType)
      ..writeByte(13)
      ..write(obj.comment)
      ..writeByte(14)
      ..write(obj.workOrderId)
      ..writeByte(15)
      ..write(obj.totalPercent)
      ..writeByte(16)
      ..write(obj.workplace);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
