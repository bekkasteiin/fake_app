// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AnswerOption.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerOptionAdapter extends TypeAdapter<AnswerOption> {
  @override
  final int typeId = 62;

  @override
  AnswerOption read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnswerOption(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      answerText: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnswerOption obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.answerText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerOptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
