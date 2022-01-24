import 'dart:convert';

import 'package:hive/hive.dart';

part 'Material.g.dart';

@HiveType(typeId: 36)
class Material {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String item;
  @HiveField(3)
  String uom;
  @HiveField(4)
  String quantity;

  Material({
    this.entityName,
    this.id,
    this.item,
    this.uom,
    this.quantity,
  });

  factory Material.fromJson(String str) => Material.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Material.fromMap(Map<String, dynamic> json) => Material(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        item: json["item"] == null ? null : json["item"],
        uom: json["uom"] == null ? null : json["uom"],
        quantity: json["quantity"] == null ? null : json["quantity"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "item": item == null ? null : item,
        "uom": uom == null ? null : uom,
        "quantity": quantity == null ? null : quantity,
      };
}
