import 'dart:convert';

import 'package:hive/hive.dart';

part 'ListOfEquipmentUsed.g.dart';

@HiveType(typeId: 43)
class ListOfEquipmentUsed {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String uom;
  @HiveField(3)
  String qty;
  @HiveField(4)
  String name;

  ListOfEquipmentUsed({
    this.entityName,
    this.id,
    this.uom,
    this.qty,
    this.name,
  });

  factory ListOfEquipmentUsed.fromJson(String str) =>
      ListOfEquipmentUsed.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ListOfEquipmentUsed.fromMap(Map<String, dynamic> json) =>
      ListOfEquipmentUsed(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        uom: json["uom"] == null ? null : json["uom"],
        qty: json["qty"] == null ? null : json["qty"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "uom": uom == null ? null : uom,
        "qty": qty == null ? null : qty,
        "name": name == null ? null : name,
      };
}
