// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TransportOrderPojo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TransportOrderPojoAdapter extends TypeAdapter<TransportOrderPojo> {
  @override
  final int typeId = 38;

  @override
  TransportOrderPojo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TransportOrderPojo(
      entityName: fields[0] as String,
      id: fields[1] as String,
      code: fields[2] as String,
      work: fields[3] as TransportOrderPojoWork,
      shift: fields[4] as String,
      comment: fields[5] as String,
      orderDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, TransportOrderPojo obj) {
    writer
      ..writeByte(7)
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
      ..write(obj.comment)
      ..writeByte(6)
      ..write(obj.orderDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TransportOrderPojoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
