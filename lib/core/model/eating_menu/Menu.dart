import 'dart:convert';

import 'package:hive/hive.dart';

part 'Menu.g.dart';

@HiveType(typeId: 21)
class Menu {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;

  Menu({
    this.entityName,
    this.instanceName,
    this.id,
  });

  factory Menu.fromJson(String str) => Menu.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Menu.fromMap(Map<String, dynamic> json) => Menu(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
      };
}
