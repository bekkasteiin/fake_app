// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AllOrderPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AllOrderPojoAdapter extends TypeAdapter<AllOrderPojo> {
  @override
  final int typeId = 31;

  @override
  AllOrderPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllOrderPojo(
      entityName: fields[0] as String,
      id: fields[1] as String,
      workOrderPojo: fields[2] as WorkOrderPojo,
      responsible: fields[3] as bool,
      type: fields[4] as String,
      repairOrderPojo: fields[5] as RepairOrderPojo,
      transportOrderPojo: fields[6] as TransportOrderPojo,
      workOrderShift: fields[7] as WorkOrderShift,
    );
  }

  @override
  void write(BinaryWriter writer, AllOrderPojo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.workOrderPojo)
      ..writeByte(3)
      ..write(obj.responsible)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.repairOrderPojo)
      ..writeByte(6)
      ..write(obj.transportOrderPojo)
      ..writeByte(7)
      ..write(obj.workOrderShift);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllOrderPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
