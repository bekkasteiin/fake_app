// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Order.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderAdapter extends TypeAdapter<Order> {
  @override
  final int typeId = 12;

  @override
  Order read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Order(
      entityName: fields[0] as String,
      id: fields[1] as String,
      code: fields[2] as String,
      proposedDateAndTime: fields[3] as DateTime,
      driver: fields[4] as Driver,
      person: (fields[5] as List)?.cast<Person>(),
      vehicle: fields[6] as Vehicle,
    );
  }

  @override
  void write(BinaryWriter writer, Order obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.proposedDateAndTime)
      ..writeByte(4)
      ..write(obj.driver)
      ..writeByte(5)
      ..write(obj.person)
      ..writeByte(6)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
