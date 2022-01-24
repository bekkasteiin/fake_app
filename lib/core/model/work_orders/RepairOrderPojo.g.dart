// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RepairOrderPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepairOrderPojoAdapter extends TypeAdapter<RepairOrderPojo> {
  @override
  final int typeId = 32;

  @override
  RepairOrderPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepairOrderPojo(
      entityName: fields[0] as String,
      id: fields[1] as String,
      number: fields[2] as String,
      repairOrderId: fields[3] as String,
      laborSpending: (fields[4] as List)?.cast<RepairOrderPojoLaborSpending>(),
      work: fields[5] as RepairOrderPojoWork,
      repairType: fields[6] as String,
      comment: fields[7] as String,
      asset: fields[8] as String,
      orderDate: fields[9] as DateTime,
      planEndDate: fields[10] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RepairOrderPojo obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.repairOrderId)
      ..writeByte(4)
      ..write(obj.laborSpending)
      ..writeByte(5)
      ..write(obj.work)
      ..writeByte(6)
      ..write(obj.repairType)
      ..writeByte(7)
      ..write(obj.comment)
      ..writeByte(8)
      ..write(obj.asset)
      ..writeByte(9)
      ..write(obj.orderDate)
      ..writeByte(10)
      ..write(obj.planEndDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepairOrderPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
