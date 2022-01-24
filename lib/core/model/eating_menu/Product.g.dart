// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 22;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      name: fields[3] as String,
      parentType: fields[4] as String,
      parentId: fields[5] as String,
      group: fields[6] as String,
      image: fields[7] as String,
      uom: fields[8] as String,
      amount: fields[9] as double,
      quantity: fields[10] as double,
      calories: fields[11] as double,
      dayOfWeek: fields[12] as int,
      mealtime: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.parentType)
      ..writeByte(5)
      ..write(obj.parentId)
      ..writeByte(6)
      ..write(obj.group)
      ..writeByte(7)
      ..write(obj.image)
      ..writeByte(8)
      ..write(obj.uom)
      ..writeByte(9)
      ..write(obj.amount)
      ..writeByte(10)
      ..write(obj.quantity)
      ..writeByte(11)
      ..write(obj.calories)
      ..writeByte(12)
      ..write(obj.dayOfWeek)
      ..writeByte(13)
      ..write(obj.mealtime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
