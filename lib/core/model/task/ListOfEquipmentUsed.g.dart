// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListOfEquipmentUsed.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListOfEquipmentUsedAdapter extends TypeAdapter<ListOfEquipmentUsed> {
  @override
  final int typeId = 29;

  @override
  ListOfEquipmentUsed read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListOfEquipmentUsed(
      entityName: fields[0] as String,
      id: fields[1] as String,
      uom: fields[2] as String,
      qty: fields[3] as String,
      name: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ListOfEquipmentUsed obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.uom)
      ..writeByte(3)
      ..write(obj.qty)
      ..writeByte(4)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListOfEquipmentUsedAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
