// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Question.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuestionAdapter extends TypeAdapter<Question> {
  @override
  final int typeId = 60;

  @override
  Question read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Question(
      entityName: fields[0] as String,
      instanceName: fields[1] as String,
      id: fields[2] as String,
      category: fields[5] as String,
      questionText: fields[3] as String,
      instruction: fields[4] as String,
      answerOptions: (fields[6] as List)?.cast<AnswerOption>(),
    );
  }

  @override
  void write(BinaryWriter writer, Question obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.entityName)
      ..writeByte(1)
      ..write(obj.instanceName)
      ..writeByte(2)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.questionText)
      ..writeByte(4)
      ..write(obj.instruction)
      ..writeByte(5)
      ..write(obj.category)
      ..writeByte(6)
      ..write(obj.answerOptions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
