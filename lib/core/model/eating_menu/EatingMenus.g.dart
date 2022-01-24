// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EatingMenus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EatingMenusAdapter extends TypeAdapter<EatingMenus> {
  @override
  final int typeId = 19;

  @override
  EatingMenus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return EatingMenus(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      name: fields[3] as String,
      complexes: (fields[4] as List)?.cast<Complex>(),
      products: (fields[5] as List)?.cast<Product>(),
      location: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, EatingMenus obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.complexes)
      ..writeByte(5)
      ..write(obj.products)
      ..writeByte(6)
      ..write(obj.location);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EatingMenusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
