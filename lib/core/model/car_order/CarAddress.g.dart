// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CarAddress.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAddressAdapter extends TypeAdapter<CarAddress> {
  @override
  final int typeId = 120;

  @override
  CarAddress read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CarAddress(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CarAddress obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAddressAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
