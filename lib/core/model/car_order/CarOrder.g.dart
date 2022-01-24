// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CarOrder.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarOrderAdapter extends TypeAdapter<CarOrder> {
  @override
  final int typeId = 66;

  @override
  CarOrder read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarOrder(
      entityName: fields[0] as String,
      id: fields[1] as String,
      status: fields[2] as String,
      requestedDate: fields[3] as DateTime,
      toAddress: fields[4] as String,
      fromAddress: fields[5] as String,
      count: fields[6] as String,
      comment: fields[7] as String,
      createDate: fields[8] as DateTime,
      order: fields[10] as Order,
      isEmergency: fields[11] as bool,
      typeOfCar: fields[12] as String,
      rating: fields[13] as int,
      cost: fields[14] as num,
    )..requestedTime = fields[9] as DateTime;
  }

  @override
  void write(BinaryWriter writer, CarOrder obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.requestedDate)
      ..writeByte(4)
      ..write(obj.toAddress)
      ..writeByte(5)
      ..write(obj.fromAddress)
      ..writeByte(6)
      ..write(obj.count)
      ..writeByte(7)
      ..write(obj.comment)
      ..writeByte(8)
      ..write(obj.createDate)
      ..writeByte(9)
      ..write(obj.requestedTime)
      ..writeByte(10)
      ..write(obj.order)
      ..writeByte(11)
      ..write(obj.isEmergency)
      ..writeByte(12)
      ..write(obj.typeOfCar)
      ..writeByte(13)
      ..write(obj.rating)
      ..writeByte(14)
      ..write(obj.cost);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarOrderAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
