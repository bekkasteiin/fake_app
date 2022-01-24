import 'dart:convert';

import 'package:hive/hive.dart';

part 'FoodLimits.g.dart';

@HiveType(typeId: 70)
class FoodLimits {
  FoodLimits({
    this.monthLimit,
    this.dayLimit,
    this.spent,
    this.left,
  });

  @HiveField(0)
  num monthLimit;
  @HiveField(1)
  num dayLimit;
  @HiveField(2)
  num spent;
  @HiveField(3)
  num left;

  factory FoodLimits.fromJson(String str) =>
      FoodLimits.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FoodLimits.fromMap(Map<String, dynamic> json) => FoodLimits(
        monthLimit: json["monthLimit"],
        dayLimit: json["dayLimit"],
        spent: json["spent"],
        left: json["left"],
      );

  Map<String, dynamic> toMap() => {
        "monthLimit": monthLimit,
        "dayLimit": dayLimit,
        "spent": spent,
        "left": left,
      };
}
