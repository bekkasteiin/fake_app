// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Answer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnswerAdapter extends TypeAdapter<Answer> {
  @override
  final int typeId = 61;

  @override
  Answer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Answer(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      answer: fields[3] as String,
      correct: fields[4] as bool,
      question: fields[5] as Question,
    );
  }

  @override
  void write(BinaryWriter writer, Answer obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.answer)
      ..writeByte(4)
      ..write(obj.correct)
      ..writeByte(5)
      ..write(obj.question);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnswerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
