import 'dart:convert';

import 'package:hive/hive.dart';

part 'Indicator.g.dart';

@HiveType(typeId: 72)
class Indicator {
  Indicator({
    this.entityName,
    this.id,
    this.code,
    this.isSystemRecord,
    this.langValue,
    this.version,
    this.langValue1,
  });

  @HiveField(1)
  String entityName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  bool isSystemRecord;
  @HiveField(5)
  String langValue;
  @HiveField(6)
  int version;
  @HiveField(7)
  String langValue1;

  factory Indicator.fromJson(String str) => Indicator.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Indicator.fromMap(Map<String, dynamic> json) => Indicator(
        entityName: json["_entityName"],
        id: json["id"],
        code: json["code"],
        isSystemRecord: json["isSystemRecord"],
        langValue: json["langValue"],
        version: json["version"],
        langValue1: json["langValue1"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "code": code,
        "isSystemRecord": isSystemRecord,
        "langValue": langValue,
        "version": version,
        "langValue1": langValue1,
      };
}
