// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LaborSpending.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LaborSpendingAdapter extends TypeAdapter<LaborSpending> {
  @override
  final int typeId = 28;

  @override
  LaborSpending read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LaborSpending(
      entityName: fields[0] as String,
      id: fields[1] as String,
      factEndDate: fields[2] as DateTime,
      factObject: fields[3] as double,
      percentCompletion: fields[4] as double,
      status: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LaborSpending obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.factEndDate)
      ..writeByte(3)
      ..write(obj.factObject)
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
      other is LaborSpendingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
