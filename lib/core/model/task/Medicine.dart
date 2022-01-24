import 'dart:convert';

import 'package:hive/hive.dart';

part 'Medicine.g.dart';

@HiveType(typeId: 27)
class Medicine {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  bool check;
  @HiveField(3)
  DateTime checkDate;

  Medicine({
    this.entityName,
    this.id,
    this.check,
    this.checkDate,
  });

  factory Medicine.fromJson(String str) => Medicine.fromMap(json.decode(str));

  factory Medicine.fromMap(Map<String, dynamic> json) => Medicine(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        check: json["check"] == null ? null : json["check"],
        checkDate: json["checkDate"] == null
            ? null
            : DateTime.parse(json["checkDate"]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "check": check == null ? null : check,
        "checkDate": checkDate == null ? null : checkDate.toIso8601String(),
      };
}
