import 'package:hive/hive.dart';

import 'AnswerOption.dart';

part 'Question.g.dart';

@HiveType(typeId: 60)
class Question {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String questionText;
  @HiveField(4)
  String instruction;
  @HiveField(5)
  String category;
  @HiveField(6)
  List<AnswerOption> answerOptions;

  Question({
    this.entityName,
    this.instanceName,
    this.id,
    this.category,
    this.questionText,
    this.instruction,
    this.answerOptions,
  });

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        category: json["category"] == null ? null : json["category"],
        instruction: json["instruction"] == null ? null : json["instruction"],
        questionText:
            json["questionText"] == null ? null : json["questionText"],
        answerOptions: json["answerOptions"] == null
            ? []
            : List<AnswerOption>.from(
                json["answerOptions"].map((x) => AnswerOption.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "questionText": questionText == null ? null : questionText,
        "category": category == null ? null : category,
        "instruction": instruction == null ? null : instruction,
        "answerOptions": answerOptions == null
            ? []
            : List<dynamic>.from(answerOptions.map((x) => x.toMap())),
      };

  Map<String, dynamic> toBaseMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "questionText": questionText == null ? null : questionText,
      };
}
