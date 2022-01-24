// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OrdinalSales.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrdinalSalesAdapter extends TypeAdapter<OrdinalSales> {
  @override
  final int typeId = 64;

  @override
  OrdinalSales read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrdinalSales(
      day: fields[0] as DateTime,
      percent: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, OrdinalSales obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.day)
      ..writeByte(1)
      ..write(obj.percent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrdinalSalesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
