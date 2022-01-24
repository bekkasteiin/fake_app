import 'dart:convert';

import 'package:hive/hive.dart';

import 'Indicator.dart';
import 'Uom.dart';

part 'IndicatorValueList.g.dart';

@HiveType(typeId: 73)
class IndicatorValueList {
  IndicatorValueList({
    this.entityName,
    this.id,
    this.indicator,
    this.uom,
    this.indicatorValue,
  });

  @HiveField(1)
  String entityName;
  @HiveField(2)
  String id;
  @HiveField(3)
  Indicator indicator;
  @HiveField(4)
  Uom uom;
  @HiveField(5)
  double indicatorValue;

  factory IndicatorValueList.fromJson(String str) =>
      IndicatorValueList.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory IndicatorValueList.fromMap(Map<String, dynamic> json) =>
      IndicatorValueList(
        entityName: json["_entityName"],
        id: json["id"],
        indicator: json["indicator"] == null
            ? null
            : Indicator.fromMap(json["indicator"]),
        uom: json["uom"] == null ? null : Uom.fromMap(json["uom"]),
        indicatorValue: json["indicatorValue"] == null
            ? 0.0
            : json["indicatorValue"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "indicator": indicator.toMap(),
        "uom": uom.toMap(),
        "indicatorValue": indicatorValue,
      };
}
