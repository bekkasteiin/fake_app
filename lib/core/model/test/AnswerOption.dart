import 'package:hive/hive.dart';

part 'AnswerOption.g.dart';

@HiveType(typeId: 62)
class AnswerOption {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String answerText;

  AnswerOption({
    this.entityName,
    this.instanceName,
    this.id,
    this.answerText,
  });

  factory AnswerOption.fromMap(Map<String, dynamic> json) => AnswerOption(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        answerText: json["answerText"] == null ? null : json["answerText"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "answerText": answerText == null ? null : answerText,
      };
}
