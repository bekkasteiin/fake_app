import 'dart:convert';

import 'package:hive/hive.dart';

part 'message_dictionary.g.dart';


@HiveType(typeId: 123)
class AbstractDictionary {
  AbstractDictionary({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.langValue,
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

  factory AbstractDictionary.fromJson(String str) =>
      AbstractDictionary.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AbstractDictionary.fromMap(Map<String, dynamic> json) =>
      AbstractDictionary(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        langValue: json["langValue"] == null ? null : json["langValue"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "langValue": langValue == null ? null : langValue,
      };
}
