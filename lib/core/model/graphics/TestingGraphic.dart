import 'dart:convert';

import 'package:hive/hive.dart';

import 'OrdinalSales.dart';

part 'TestingGraphic.g.dart';

@HiveType(typeId: 63)
class TestingGraphic {
  @HiveField(0)
  String id;
  @HiveField(1)
  String period;
  @HiveField(2)
  List<OrdinalSales> testingGraphicDynamic;

  TestingGraphic({
    this.id,
    this.period,
    this.testingGraphicDynamic,
  });

  factory TestingGraphic.fromJson(String str) =>
      TestingGraphic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TestingGraphic.fromMap(Map<String, dynamic> json) => TestingGraphic(
        id: json["id"] == null ? null : json["id"],
        period: json["period"] == null ? null : json["period"],
        testingGraphicDynamic: json["dynamic"] == null
            ? []
            : List<OrdinalSales>.from(
                json["dynamic"].map((x) => OrdinalSales.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "period": period == null ? null : period,
        "dynamic": testingGraphicDynamic == null
            ? []
            : List<dynamic>.from(testingGraphicDynamic.map((x) => x.toMap())),
      };
}
