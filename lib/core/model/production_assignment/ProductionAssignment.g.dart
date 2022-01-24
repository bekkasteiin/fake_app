// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProductionAssignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductionAssignmentAdapter extends TypeAdapter<ProductionAssignment> {
  @override
  final int typeId = 53;

  @override
  ProductionAssignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductionAssignment(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      code: fields[3] as String,
      docDate: fields[4] as DateTime,
      type: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductionAssignment obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.code)
      ..writeByte(4)
      ..write(obj.docDate)
      ..writeByte(5)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductionAssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
