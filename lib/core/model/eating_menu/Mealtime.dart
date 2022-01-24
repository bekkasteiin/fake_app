// To parse this JSON data, do
//
//     final mealtime = mealtimeFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'Mealtime.g.dart';

@HiveType(typeId: 68)
class Mealtime {
  Mealtime({
    this.entityName,
    this.instanceName,
    this.id,
    this.langValue1,
    this.startTime,
    this.endTime,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String langValue1;
  @HiveField(4)
  String startTime;
  @HiveField(5)
  String endTime;

  factory Mealtime.fromJson(String str) => Mealtime.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Mealtime.fromMap(Map<String, dynamic> json) => Mealtime(
        entityName: json["_entityName"],
        instanceName: json["_instanceName"],
        id: json["id"],
        langValue1: json["langValue1"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "_instanceName": instanceName,
        "id": id,
        "langValue1": langValue1,
        "startTime": startTime,
        "endTime": endTime,
      };
}
