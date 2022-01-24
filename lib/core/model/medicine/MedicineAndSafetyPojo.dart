import 'dart:convert';

import 'package:hive/hive.dart';

part 'MedicineAndSafetyPojo.g.dart';

@HiveType(typeId: 47)
class MedicineAndSafetyPojo {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  bool safety;
  @HiveField(5)
  bool medicine;
  @HiveField(6)
  DateTime checkDate;

  MedicineAndSafetyPojo({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.safety,
    this.medicine,
    this.checkDate,
  });

  factory MedicineAndSafetyPojo.fromJson(String str) =>
      MedicineAndSafetyPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MedicineAndSafetyPojo.fromMap(Map<String, dynamic> json) =>
      MedicineAndSafetyPojo(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        safety: json["safety"] == null ? null : json["safety"],
        medicine: json["medicine"] == null ? null : json["medicine"],
        checkDate: json["checkDate"] == null
            ? null
            : DateTime.parse(json["checkDate"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "safety": safety == null ? null : safety,
        "medicine": medicine == null ? null : medicine,
        "checkDate": checkDate == null ? null : checkDate.toIso8601String(),
      };
}
