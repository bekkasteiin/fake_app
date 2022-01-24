// To parse this JSON data, do
//
//     final checkPoint = checkPointFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'CheckPoint.g.dart';

@HiveType(typeId: 15)
class CheckPoint {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime dateAndTime;
  @HiveField(4)
  String controlPoint;
  @HiveField(5)
  String direction;

  CheckPoint({
    this.entityName,
    this.instanceName,
    this.id,
    this.dateAndTime,
    this.controlPoint,
    this.direction,
  });

  factory CheckPoint.fromJson(String str) =>
      CheckPoint.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckPoint.fromMap(Map<String, dynamic> json) => CheckPoint(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        dateAndTime: json["dateAndTime"] == null
            ? null
            : DateTime.parse(json["dateAndTime"]),
        controlPoint:
            json["controlPoint"] == null ? null : json["controlPoint"],
        direction: json["direction"] == null ? null : json["direction"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "dateAndTime":
            dateAndTime == null ? null : dateAndTime.toIso8601String(),
        "controlPoint": controlPoint == null ? null : controlPoint,
        "direction": direction == null ? null : direction,
      };
}
