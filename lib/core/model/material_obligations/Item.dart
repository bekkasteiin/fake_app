import 'dart:convert';

import 'package:hive/hive.dart';

part 'Item.g.dart';

@HiveType(typeId: 25)
class Item {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime date;
  @HiveField(3)
  String image;
  @HiveField(4)
  double quantity;
  @HiveField(5)
  double cost;
  @HiveField(6)
  String name;
  @HiveField(7)
  String cause;
  @HiveField(8)
  String comment;
  @HiveField(9)
  String uom;
  @HiveField(10)
  bool isPersonal;

  Item(
      {this.entityName,
      this.id,
      this.date,
      this.image,
      this.quantity,
      this.cost,
      this.name,
      this.cause,
      this.comment,
      this.uom,
      this.isPersonal});

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        image: json["image"] == null ? null : json["image"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        cost: json["cost"] == null ? null : json["cost"],
        name: json["name"] == null ? null : json["name"],
        cause: json["cause"] == null ? null : json["cause"],
        comment: json["comment"] == null ? null : json["comment"],
        uom: json["uom"] == null ? null : json["uom"],
        isPersonal: json["isPersonal"] == null ? null : json["isPersonal"],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        "id": id,
        "date": date == null ? null : date.toIso8601String(),
        "image": image,
        "quantity": quantity,
        "cost": cost,
        'name': name,
        'cause': cause,
        "comment": comment,
        "uom": uom,
        "isPersonal": isPersonal,
      };
}
