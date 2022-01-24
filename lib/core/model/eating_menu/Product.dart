import 'dart:convert';

import 'package:hive/hive.dart';

part 'Product.g.dart';

@HiveType(typeId: 22)
class Product {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String name;
  @HiveField(4)
  String parentType;
  @HiveField(5)
  String parentId;
  @HiveField(6)
  String group;
  @HiveField(7)
  String image;
  @HiveField(8)
  String uom;
  @HiveField(9)
  double amount;
  @HiveField(10)
  double quantity;
  @HiveField(11)
  double calories;
  @HiveField(12)
  int dayOfWeek;
  @HiveField(13)
  String mealtime;

  Product({
    this.entityName,
    this.instanceName,
    this.id,
    this.name,
    this.parentType,
    this.parentId,
    this.group,
    this.image,
    this.uom,
    this.amount,
    this.quantity,
    this.calories,
    this.dayOfWeek,
    this.mealtime,
  });

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        name: json['name'],
        dayOfWeek: json['dayOfWeek'],
        mealtime: json['mealtime'],
        parentType: json['parentType'],
        parentId: json['parentId'],
        group: json['group'],
        image: json['image'],
        uom: json['uom'],
        amount: json['amount'],
        quantity: json['quantity'],
        calories: json['calories'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'dayOfWeek': dayOfWeek,
        'mealtime': mealtime,
        'name': name,
        'parentType': parentType,
        'parentId': parentId,
        'group': group,
        'image': image,
        'uom': uom,
        'amount': amount,
        'quantity': quantity,
        'calories': calories,
      };
}
