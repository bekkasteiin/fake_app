import 'dart:convert';

import 'package:hive/hive.dart';

import 'Ppe.dart';

part 'PersonalProtectionEquipment.g.dart';

@HiveType(typeId: 6)
class PersonalProtectionEquipment {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String perscent;
  @HiveField(4)
  List<Ppe> ppes;

  PersonalProtectionEquipment({
    this.entityName,
    this.instanceName,
    this.id,
    this.perscent,
    this.ppes,
  });

  fromJson(String str) => PersonalProtectionEquipment.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PersonalProtectionEquipment.fromMap(Map<String, dynamic> json) =>
      PersonalProtectionEquipment(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        perscent: json["perscent"] == null ? null : json["perscent"],
        ppes: json["ppes"] == null
            ? []
            : List<Ppe>.from(json["ppes"].map((x) => Ppe.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "perscent": perscent == null ? null : perscent,
        "ppes":
            ppes == null ? [] : List<dynamic>.from(ppes.map((x) => x.toMap())),
      };
}
