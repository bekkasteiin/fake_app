// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Anthropometry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnthropometryAdapter extends TypeAdapter<Anthropometry> {
  @override
  final int typeId = 1;

  @override
  Anthropometry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Anthropometry(
      entityName: fields[0] as String,
      id: fields[1] as String,
      clothingSize: fields[2] as String,
      shoeSize: fields[3] as String,
      handSize: fields[4] as String,
      personGroupId: fields[5] as String,
      weight: fields[6] as double,
      headSize: fields[7] as String,
      height: fields[8] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Anthropometry obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.clothingSize)
      ..writeByte(3)
      ..write(obj.shoeSize)
      ..writeByte(4)
      ..write(obj.handSize)
      ..writeByte(5)
      ..write(obj.personGroupId)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.headSize)
      ..writeByte(8)
      ..write(obj.height);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnthropometryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
