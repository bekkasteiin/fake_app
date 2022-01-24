import 'dart:convert';

import 'package:hive/hive.dart';

part 'ShiftDetailShift.g.dart';

@HiveType(typeId: 78)
class ShiftDetailShift {
  ShiftDetailShift({
    this.entityName,
    this.id,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;

  factory ShiftDetailShift.fromJson(String str) =>
      ShiftDetailShift.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ShiftDetailShift.fromMap(Map<String, dynamic> json) =>
      ShiftDetailShift(
        entityName: json["_entityName"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
      };
}
