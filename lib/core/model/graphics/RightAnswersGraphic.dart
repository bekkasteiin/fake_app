import 'dart:convert';

import 'package:hive/hive.dart';

part 'RightAnswersGraphic.g.dart';

@HiveType(typeId: 54)
class RightAnswersGraphic {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  int allAnswers;
  @HiveField(4)
  int rightAnswers;
  @HiveField(5)
  double percent;

  RightAnswersGraphic({
    this.entityName,
    this.instanceName,
    this.id,
    this.allAnswers,
    this.rightAnswers,
    this.percent,
  });

  fromJson(String str) => RightAnswersGraphic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RightAnswersGraphic.fromMap(Map<String, dynamic> json) =>
      RightAnswersGraphic(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        allAnswers: json["allAnswers"] == null ? null : json["allAnswers"],
        rightAnswers:
            json["rightAnswers"] == null ? null : json["rightAnswers"],
        percent: json["percent"] == null ? null : json["percent"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "allAnswers": allAnswers == null ? null : allAnswers,
        "rightAnswers": rightAnswers == null ? null : rightAnswers,
        "percent": percent == null ? null : percent,
      };
}
