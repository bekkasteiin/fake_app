import 'dart:convert';

import 'package:hive/hive.dart';

part 'ProductionAssignment.g.dart';

@HiveType(typeId: 53)
class ProductionAssignment {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  DateTime docDate;
  @HiveField(5)
  String type;

  ProductionAssignment({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.docDate,
    this.type,
  });

  factory ProductionAssignment.fromJson(String str) =>
      ProductionAssignment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductionAssignment.fromMap(Map<String, dynamic> json) =>
      ProductionAssignment(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        docDate:
            json["docDate"] == null ? null : DateTime.parse(json["docDate"]),
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "docDate": docDate == null ? null : docDate.toIso8601String(),
        "type": type == null ? null : type,
      };
}
