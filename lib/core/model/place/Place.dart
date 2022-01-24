import 'dart:convert';

import 'package:hive/hive.dart';

part 'Place.g.dart';

@HiveType(typeId: 51)
class Place {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String groupName;
  @HiveField(4)
  String name;

  Place({
    this.entityName,
    this.instanceName,
    this.id,
    this.groupName,
    this.name,
  });

  fromJson(String str) => Place.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Place.fromMap(Map<String, dynamic> json) => Place(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        groupName: json["groupName"] == null ? null : json["groupName"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "groupName": groupName == null ? null : groupName,
        "name": name == null ? null : name,
      };
}
