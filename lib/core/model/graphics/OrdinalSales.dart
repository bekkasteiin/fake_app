import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/util_models.dart';

part 'OrdinalSales.g.dart';

@HiveType(typeId: 64)
class OrdinalSales {
  @HiveField(0)
  final DateTime day;
  @HiveField(1)
  final double percent;

  OrdinalSales({this.day, this.percent});

  factory OrdinalSales.fromJson(String str) =>
      OrdinalSales.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrdinalSales.fromMap(Map<String, dynamic> json) => OrdinalSales(
        percent: json["percent"] == null ? null : json["percent"].toDouble(),
        day: json["testDate"] == null ? null : DateTime.parse(json["testDate"]),
      );

  Map<String, dynamic> toMap() => {
        "percent": percent == null ? null : percent,
        "testDate": day == null ? null : dateTimeToString(day),
      };
}
