import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/ppe/Ppe.dart';

import 'Item.dart';

part 'MaterialObligations.g.dart';

@HiveType(typeId: 24)
class MaterialObligations {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double totalAmount;
  @HiveField(3)
  double total;
  @HiveField(4)
  List<Ppe> ppes;
  @HiveField(5)
  List<Item> items;
  @HiveField(6)
  List<Item> tools;

  MaterialObligations({
    this.entityName,
    this.id,
    this.totalAmount,
    this.total,
    this.ppes,
    this.items,
    this.tools,
  });

  fromJson(String str) => MaterialObligations.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MaterialObligations.fromMap(Map<String, dynamic> json) =>
      MaterialObligations(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        totalAmount: json["totalAmount"] == null ? null : json["totalAmount"],
        total: json["total"] == null ? null : json["total"],
        ppes: json["ppes"] == null
            ? []
            : List<Ppe>.from(json["ppes"].map((x) => Ppe.fromMap(x))),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
        tools: json["tools"] == null
            ? []
            : List<Item>.from(json["tools"].map((x) => Item.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "totalAmount": totalAmount == null ? null : totalAmount,
        "total": total == null ? null : total,
        "ppes":
            ppes == null ? [] : List<dynamic>.from(ppes.map((x) => x.toMap())),
        "items": items == null
            ? []
            : List<dynamic>.from(items.map((x) => x.toMap())),
        "tools": tools == null
            ? []
            : List<dynamic>.from(tools.map((x) => x.toMap())),
      };
}
