// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 26;

  @override
  Task read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task(
      entityName: fields[0] as String,
      id: fields[1] as String,
      totalFact: fields[2] as double,
      safetyExam: fields[3] as Medicine,
      plannedVolume: fields[4] as double,
      personPojo: (fields[5] as List)?.cast<PersonPojo>(),
      medicine: fields[6] as Medicine,
      type: fields[7] as String,
      plannedEndDate: fields[8] as DateTime,
      listOfEquipmentUsed: (fields[9] as List)?.cast<ListOfEquipmentUsed>(),
      number: fields[10] as String,
      uom: fields[11] as String,
      laborSpending: (fields[12] as List)?.cast<LaborSpending>(),
      workOrderId: fields[13] as String,
      totalPercent: fields[14] as double,
      workplace: fields[15] as String,
      object: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.totalFact)
      ..writeByte(3)
      ..write(obj.safetyExam)
      ..writeByte(4)
      ..write(obj.plannedVolume)
      ..writeByte(5)
      ..write(obj.personPojo)
      ..writeByte(6)
      ..write(obj.medicine)
      ..writeByte(7)
      ..write(obj.type)
      ..writeByte(8)
      ..write(obj.plannedEndDate)
      ..writeByte(9)
      ..write(obj.listOfEquipmentUsed)
      ..writeByte(10)
      ..write(obj.number)
      ..writeByte(11)
      ..write(obj.uom)
      ..writeByte(12)
      ..write(obj.laborSpending)
      ..writeByte(13)
      ..write(obj.workOrderId)
      ..writeByte(14)
      ..write(obj.totalPercent)
      ..writeByte(15)
      ..write(obj.workplace)
      ..writeByte(16)
      ..write(obj.object);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
