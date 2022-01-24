import 'dart:convert';

import 'package:hive/hive.dart';

part 'GroupAccess.g.dart';

@HiveType(typeId: 5)
class GroupAccess {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String name;

  GroupAccess({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.name,
  });

  GroupAccess fromJson(String str) => GroupAccess.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory GroupAccess.fromMap(Map<String, dynamic> json) => GroupAccess(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
      };
}
