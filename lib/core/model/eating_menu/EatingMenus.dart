import 'dart:convert';

import 'package:hive/hive.dart';

import 'Complex.dart';
import 'Product.dart';

part 'EatingMenus.g.dart';

@HiveType(typeId: 19)
class EatingMenus {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String name;
  @HiveField(4)
  List<Complex> complexes;
  @HiveField(5)
  List<Product> products;
  @HiveField(6)
  String location;

  EatingMenus(
      {this.entityName,
      this.instanceName,
      this.id,
      this.name,
      this.complexes,
      this.products,
      this.location});

  fromJson(String str) => EatingMenus.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EatingMenus.fromMap(Map<String, dynamic> json) => EatingMenus(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : json["location"],
        complexes: json["complexes"] == null
            ? []
            : List<Complex>.from(
                json["complexes"].map((x) => Complex.fromMap(x))),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "location": location == null ? null : location,
        "complexes": complexes == null
            ? []
            : List<dynamic>.from(complexes.map((x) => x.toMap())),
        "products": products == null
            ? []
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
