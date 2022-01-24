import 'dart:convert';

import 'package:hive/hive.dart';

part 'OverCategoryGraphic.g.dart';

@HiveType(typeId: 55)
class OverCategoryGraphic {
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
  String category;
  @HiveField(6)
  double percent;

  OverCategoryGraphic({
    this.entityName,
    this.instanceName,
    this.id,
    this.allAnswers,
    this.rightAnswers,
    this.category,
    this.percent,
  });

  fromJson(String str) => OverCategoryGraphic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OverCategoryGraphic.fromMap(Map<String, dynamic> json) =>
      OverCategoryGraphic(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        allAnswers: json["allAnswers"] == null ? null : json["allAnswers"],
        rightAnswers:
            json["rightAnswers"] == null ? null : json["rightAnswers"],
        category: json["category"] == null ? null : json["category"],
        percent: json["percent"] == null ? null : json["percent"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "allAnswers": allAnswers == null ? null : allAnswers,
        "rightAnswers": rightAnswers == null ? null : rightAnswers,
        "category": category == null ? null : category,
        "percent": percent == null ? null : percent,
      };
}
