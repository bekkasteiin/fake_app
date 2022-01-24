import 'dart:convert';

import 'package:hive/hive.dart';

import 'message_dictionary.dart';

part 'condition_category.g.dart';

@HiveType(typeId: 122)
class ConditionCategory {
  ConditionCategory({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.langValue,
    this.conditions,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String langValue;
  @HiveField(5)
  List<AbstractDictionary> conditions;

  factory ConditionCategory.fromJson(String str) =>
      ConditionCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConditionCategory.fromMap(Map<String, dynamic> json) =>
      ConditionCategory(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json['code'],
        langValue: json["langValue"] == null ? null : json["langValue"],
        conditions: json["conditions"] == null
            ? null
            : List<AbstractDictionary>.from(
                json["conditions"].map((x) => AbstractDictionary.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "langValue": langValue == null ? null : langValue,
        "conditions": conditions == null
            ? null
            : List<dynamic>.from(conditions.map((x) => x.toMap())),
      };
}
