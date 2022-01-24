import 'dart:convert';

import 'package:hive/hive.dart';

import 'ShiftDetailShift.dart';

part 'ShiftDetail.g.dart';

@HiveType(typeId: 76)
class ShiftDetail {
  ShiftDetail({
    this.entityName,
    this.id,
    this.hours,
    this.isNight,
    this.shift,
    this.dayOrder,
    this.version,
    this.startTime,
    this.endTime,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double hours;
  @HiveField(3)
  bool isNight;
  @HiveField(4)
  ShiftDetailShift shift;
  @HiveField(5)
  int dayOrder;
  @HiveField(6)
  int version;
  @HiveField(7)
  String startTime;
  @HiveField(8)
  String endTime;

  factory ShiftDetail.fromJson(String str) =>
      ShiftDetail.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShiftDetail.fromMap(Map<String, dynamic> json) => ShiftDetail(
        entityName: json["_entityName"],
        id: json["id"],
        hours: json["hours"],
        isNight: json["isNight"],
        shift: json["shift"] == null
            ? null
            : ShiftDetailShift.fromMap(json["shift"]),
        dayOrder: json["dayOrder"],
        version: json["version"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "hours": hours,
        "isNight": isNight,
        "shift": shift.toMap(),
        "dayOrder": dayOrder,
        "version": version,
        "startTime": startTime,
        "endTime": endTime,
      };
}
