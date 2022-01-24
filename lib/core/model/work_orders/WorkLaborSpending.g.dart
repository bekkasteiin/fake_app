// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WorkLaborSpending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkLaborSpendingAdapter extends TypeAdapter<WorkLaborSpending> {
  @override
  final int typeId = 40;

  @override
  WorkLaborSpending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkLaborSpending(
      entityName: fields[0] as String,
      id: fields[1] as String,
      dateAndTime: fields[2] as DateTime,
      milage: fields[3] as double,
      tripQuantity: fields[4] as double,
      turnover: fields[5] as double,
      status: fields[6] as String,
      uom: fields[7] as String,
      fact: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, WorkLaborSpending obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.dateAndTime)
      ..writeByte(3)
      ..write(obj.milage)
      ..writeByte(4)
      ..write(obj.tripQuantity)
      ..writeByte(5)
      ..write(obj.turnover)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.uom)
      ..writeByte(8)
      ..write(obj.fact);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkLaborSpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
