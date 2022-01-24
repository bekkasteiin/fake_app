import 'dart:convert';

import 'package:hive/hive.dart';

import 'IndicatorValueList.dart';
import 'IndicatorValueOnDateList.dart';

part 'EmployeeIndicatorsValue.g.dart';

@HiveType(typeId: 71)
class EmployeeIndicatorsValue {
  EmployeeIndicatorsValue({
    this.entityName,
    this.id,
    this.indicatorValueOnDateList,
    this.shiftNameRu,
    this.indicatorTotalValueList,
    this.shiftNameEn,
    this.shiftNameKz,
  });

  @HiveField(1)
  String entityName;
  @HiveField(2)
  String id;
  @HiveField(3)
  List<IndicatorValueOnDateList> indicatorValueOnDateList;
  @HiveField(4)
  String shiftNameRu;
  @HiveField(5)
  List<IndicatorValueList> indicatorTotalValueList;
  @HiveField(6)
  String shiftNameEn;
  @HiveField(7)
  String shiftNameKz;

  factory EmployeeIndicatorsValue.fromJson(String str) =>
      EmployeeIndicatorsValue.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EmployeeIndicatorsValue.fromMap(Map<String, dynamic> json) =>
      EmployeeIndicatorsValue(
        entityName: json["_entityName"],
        id: json["id"],
        indicatorValueOnDateList: json["indicatorValueOnDateList"] == null
            ? []
            : List<IndicatorValueOnDateList>.from(
                json["indicatorValueOnDateList"]
                    .map((x) => IndicatorValueOnDateList.fromMap(x))),
        shiftNameRu: json["shiftNameRu"],
        indicatorTotalValueList: json["indicatorTotalValueList"] == null
            ? []
            : List<IndicatorValueList>.from(json["indicatorTotalValueList"]
                .map((x) => IndicatorValueList.fromMap(x))),
        shiftNameEn: json["shiftNameEn"],
        shiftNameKz: json["shiftNameKz"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "indicatorValueOnDateList":
            List<dynamic>.from(indicatorValueOnDateList.map((x) => x.toMap())),
        "shiftNameRu": shiftNameRu,
        "indicatorTotalValueList":
            List<dynamic>.from(indicatorTotalValueList.map((x) => x.toMap())),
        "shiftNameEn": shiftNameEn,
        "shiftNameKz": shiftNameKz,
      };
}
