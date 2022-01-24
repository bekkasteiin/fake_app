// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkOrderShift.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkOrderShiftAdapter extends TypeAdapter<WorkOrderShift> {
  @override
  final int typeId = 44;

  @override
  WorkOrderShift read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkOrderShift(
      entityName: fields[0] as String,
      id: fields[1] as String,
      code: fields[2] as String,
      work: fields[3] as WorkOrderShiftWork,
      shift: fields[4] as String,
      orderDate: fields[5] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, WorkOrderShift obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.work)
      ..writeByte(4)
      ..write(obj.shift)
      ..writeByte(5)
      ..write(obj.orderDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkOrderShiftAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
