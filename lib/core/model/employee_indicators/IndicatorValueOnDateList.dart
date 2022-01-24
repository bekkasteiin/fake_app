import 'dart:convert';

import 'package:hive/hive.dart';

import 'Indicator.dart';
import 'IndicatorValueList.dart';
import 'IndicatorValueOndateListShift.dart';

part 'IndicatorValueOnDateList.g.dart';

@HiveType(typeId: 74)
class IndicatorValueOnDateList {
  IndicatorValueOnDateList({
    this.entityName,
    this.id,
    this.date,
    this.shift,
    this.equipment,
    this.indicatorValueList,
  });

  @HiveField(1)
  String entityName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  IndicatorValueOnDateListShift shift;
  @HiveField(5)
  Indicator equipment;
  @HiveField(6)
  List<IndicatorValueList> indicatorValueList;

  factory IndicatorValueOnDateList.fromJson(String str) =>
      IndicatorValueOnDateList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IndicatorValueOnDateList.fromMap(Map<String, dynamic> json) =>
      IndicatorValueOnDateList(
        entityName: json["_entityName"],
        id: json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        shift: json["shift"] == null
            ? null
            : IndicatorValueOnDateListShift.fromMap(json["shift"]),
        equipment: json["equipment"] == null
            ? null
            : Indicator.fromMap(json["equipment"]),
        indicatorValueList: json["indicatorValueList"] == null
            ? []
            : List<IndicatorValueList>.from(json["indicatorValueList"]
                .map((x) => IndicatorValueList.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "date": date.toIso8601String(),
        "shift": shift.toMap(),
        "equipment": equipment.toMap(),
        "indicatorValueList":
            List<dynamic>.from(indicatorValueList.map((x) => x.toMap())),
      };
}
