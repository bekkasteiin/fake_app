// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TestingGraphic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestingGraphicAdapter extends TypeAdapter<TestingGraphic> {
  @override
  final int typeId = 63;

  @override
  TestingGraphic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestingGraphic(
      id: fields[0] as String,
      period: fields[1] as String,
      testingGraphicDynamic: (fields[2] as List)?.cast<OrdinalSales>(),
    );
  }

  @override
  void write(BinaryWriter writer, TestingGraphic obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.period)
      ..writeByte(2)
      ..write(obj.testingGraphicDynamic);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestingGraphicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
