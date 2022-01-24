import 'dart:convert';

import 'package:hive/hive.dart';

import 'ShiftDetail.dart';

part 'IndicatorValueOndateListShift.g.dart';

@HiveType(typeId: 77)
class IndicatorValueOnDateListShift {
  IndicatorValueOnDateListShift({
    this.entityName,
    this.id,
    this.version,
    this.shiftDetail,
    this.name,
    this.startTime,
    this.endTime,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  int version;
  @HiveField(3)
  List<ShiftDetail> shiftDetail;
  @HiveField(4)
  String name;
  @HiveField(5)
  String startTime;
  @HiveField(6)
  String endTime;

  factory IndicatorValueOnDateListShift.fromJson(String str) =>
      IndicatorValueOnDateListShift.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IndicatorValueOnDateListShift.fromMap(Map<String, dynamic> json) =>
      IndicatorValueOnDateListShift(
        entityName: json["_entityName"],
        id: json["id"],
        version: json["version"],
        shiftDetail: json["shiftDetail"] == null
            ? []
            : List<ShiftDetail>.from(
                json["shiftDetail"].map((x) => ShiftDetail.fromMap(x))),
        name: json["name"],
        startTime: json["startTime"],
        endTime: json["endTime"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "version": version,
        "shiftDetail": List<dynamic>.from(shiftDetail.map((x) => x.toMap())),
        "name": name,
        "startTime": startTime,
        "endTime": endTime,
      };
}
