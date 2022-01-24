// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'RightAnswersGraphic.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RightAnswersGraphicAdapter extends TypeAdapter<RightAnswersGraphic> {
  @override
  final int typeId = 54;

  @override
  RightAnswersGraphic read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RightAnswersGraphic(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      allAnswers: fields[3] as int,
      rightAnswers: fields[4] as int,
      percent: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, RightAnswersGraphic obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.allAnswers)
      ..writeByte(4)
      ..write(obj.rightAnswers)
      ..writeByte(5)
      ..write(obj.percent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RightAnswersGraphicAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
