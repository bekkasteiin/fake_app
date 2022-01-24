// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Complex.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ComplexAdapter extends TypeAdapter<Complex> {
  @override
  final int typeId = 20;

  @override
  Complex read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Complex(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      name: fields[3] as String,
      menu: fields[4] as Menu,
      products: (fields[5] as List)?.cast<Product>(),
      dayOfWeek: fields[6] as int,
      mealtime: fields[7] as String,
      amount: fields[8] as double,
      image: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Complex obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.menu)
      ..writeByte(5)
      ..write(obj.products)
      ..writeByte(6)
      ..write(obj.dayOfWeek)
      ..writeByte(7)
      ..write(obj.mealtime)
      ..writeByte(8)
      ..write(obj.amount)
      ..writeByte(9)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ComplexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
