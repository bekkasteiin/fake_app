// To parse this JSON data, do
//
//     final appeals = appealsFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';

part 'appeals.g.dart';

@HiveType(typeId: 2)
class Appeals extends AbstractBpmEntity{
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String decision;
  @HiveField(5)
  String description;
  @HiveField(6)
  String topic;
  @HiveField(7)
  String type;
  @HiveField(8)
  DateTime appealLocalDateTime;
  @HiveField(9)
  String status;

  Appeals({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.decision,
    this.description,
    this.topic,
    this.type,
    this.appealLocalDateTime,
    this.status,
  });

  fromJson(String str) => Appeals.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  String toShortJson() => json.encode(toShortMap());

  factory Appeals.fromMap(Map<String, dynamic> json) => Appeals(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        decision: json["decision"] == null ? null : json["decision"],
        description: json["description"] == null ? null : json["description"],
        topic: json["topic"] == null ? null : json["topic"],
        type: json["type"] == null ? null : json["type"],
        appealLocalDateTime: json["appealLocalDateTime"] == null
            ? null
            : DateTime.parse(json["appealLocalDateTime"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "decision": decision == null ? null : decision,
        "description": description == null ? null : description,
        "topic": topic == null ? null : topic,
        "type": type == null ? null : type,
        "appealLocalDateTime": appealLocalDateTime == null
            ? null
            : appealLocalDateTime.toIso8601String(),
        "status": status == null ? null : status,
      };

  Map<String, dynamic> toShortMap() => {
        "description": description == null ? null : description,
        "topic": topic == null ? null : topic,
        "type": type == null ? null : type,
      };
}
