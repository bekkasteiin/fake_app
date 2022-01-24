import 'package:hive/hive.dart';

import 'Question.dart';

part 'Answer.g.dart';

@HiveType(typeId: 61)
class Answer {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String answer;
  @HiveField(4)
  bool correct;
  @HiveField(5)
  Question question;

  Answer({
    this.entityName,
    this.instanceName,
    this.id,
    this.answer,
    this.correct,
    this.question,
  });

  factory Answer.fromMap(Map<String, dynamic> json) => Answer(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        correct: json["correct"] == null ? null : json["correct"],
        answer: json["answer"] == null ? null : json["answer"],
        question: json["question"] == null
            ? null
            : Question.fromMap(json["question"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "correct": correct == null ? null : correct,
        "answer": answer == null ? null : answer,
        "question": question == null ? null : question.toMap(),
      };

  Map<String, dynamic> toBaseMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "answer": answer == null ? null : answer,
      };
}
