// To parse this JSON data, do
//
//     final objectName = objectNameFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Department.dart';

part 'object_name.g.dart';

@HiveType(typeId: 125)
class ObjectName {
  ObjectName({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.langValue,
    this.department,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String langValue;
  @HiveField(5)
  Department department;

  factory ObjectName.fromJson(String str) => ObjectName.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ObjectName.fromMap(Map<String, dynamic> json) => ObjectName(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    langValue: json["langValue"] == null ? null : json["langValue"],
    department: json["department"] == null ? null : Department.fromMap(json["department"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id
  };
}
