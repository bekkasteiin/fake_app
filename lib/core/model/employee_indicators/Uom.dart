import 'dart:convert';

import 'package:hive/hive.dart';

part 'Uom.g.dart';

@HiveType(typeId: 75)
class Uom {
  Uom({
    this.entityName,
    this.id,
    this.code,
    this.description,
    this.description2,
    this.description1,
    this.isSystemRecord,
    this.langValue,
    this.version,
    this.langValue1,
    this.langValue2,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String code;
  @HiveField(3)
  String description;
  @HiveField(4)
  String description2;
  @HiveField(5)
  String description1;
  @HiveField(6)
  bool isSystemRecord;
  @HiveField(7)
  String langValue;
  @HiveField(8)
  int version;
  @HiveField(9)
  String langValue1;
  @HiveField(10)
  String langValue2;

  factory Uom.fromJson(String str) => Uom.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Uom.fromMap(Map<String, dynamic> json) => Uom(
        code: json["code"],
        description: json["description"],
        description2: json["description2"],
        description1: json["description1"],
        isSystemRecord: json["isSystemRecord"],
        langValue: json["langValue"],
        version: json["version"],
        langValue1: json["langValue1"],
        langValue2: json["langValue2"] == null ? null : json["langValue2"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        "id": id,
        "code": code,
        "description": description,
        "description2": description2,
        "description1": description1,
        "isSystemRecord": isSystemRecord,
        "langValue": langValue,
        "version": version,
        "langValue1": langValue1,
        "langValue2": langValue2 == null ? null : langValue2,
      };
}
