import 'dart:convert';

import 'package:hive/hive.dart';

part 'Dish.g.dart';

@HiveType(typeId: 17)
class Dish {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  double quantity;
  @HiveField(4)
  String quantityUom;
  @HiveField(5)
  String name;
  @HiveField(6)
  double amount;
  @HiveField(7)
  double calories;
  @HiveField(8)
  String courseEating;

  Dish({
    this.entityName,
    this.instanceName,
    this.id,
    this.quantity,
    this.quantityUom,
    this.amount,
    this.name,
    this.calories,
    this.courseEating,
  });

  factory Dish.fromJson(String str) => Dish.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Dish.fromMap(Map<String, dynamic> json) => Dish(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        quantityUom: json["quantityUom"] == null ? null : json["quantityUom"],
        name: json["name"] == null ? null : json["name"],
        amount: json["amount"] == null ? 0 : json["amount"],
        calories: json["calories"] == null ? null : json["calories"],
        courseEating:
            json["courseEating"] == null ? null : json["courseEating"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "quantity": quantity == null ? null : quantity,
        "quantityUom": quantityUom == null ? null : quantityUom,
        "name": name == null ? null : name,
        "amount": amount == null ? null : amount,
        "calories": calories == null ? null : calories,
        "courseEating": courseEating == null ? null : courseEating,
      };
}
