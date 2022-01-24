// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Dish.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DishAdapter extends TypeAdapter<Dish> {
  @override
  final int typeId = 17;

  @override
  Dish read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dish(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      quantity: fields[3] as double,
      quantityUom: fields[4] as String,
      amount: fields[6] as double,
      name: fields[5] as String,
      calories: fields[7] as double,
      courseEating: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Dish obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.quantityUom)
      ..writeByte(5)
      ..write(obj.name)
      ..writeByte(6)
      ..write(obj.amount)
      ..writeByte(7)
      ..write(obj.calories)
      ..writeByte(8)
      ..write(obj.courseEating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DishAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
