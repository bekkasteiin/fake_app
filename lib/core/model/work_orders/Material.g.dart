// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Material.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MaterialAdapter extends TypeAdapter<Material> {
  @override
  final int typeId = 36;

  @override
  Material read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Material(
      entityName: fields[0] as String,
      id: fields[1] as String,
      item: fields[2] as String,
      uom: fields[3] as String,
      quantity: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Material obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.item)
      ..writeByte(3)
      ..write(obj.uom)
      ..writeByte(4)
      ..write(obj.quantity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MaterialAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
