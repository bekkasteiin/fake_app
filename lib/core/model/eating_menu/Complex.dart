import 'dart:convert';

import 'package:hive/hive.dart';

import 'Menu.dart';
import 'Product.dart';

part 'Complex.g.dart';

@HiveType(typeId: 20)
class Complex {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String name;
  @HiveField(4)
  Menu menu;
  @HiveField(5)
  List<Product> products;
  @HiveField(6)
  int dayOfWeek;
  @HiveField(7)
  String mealtime;
  @HiveField(8)
  double amount;
  @HiveField(9)
  String image;

  Complex(
      {this.entityName,
      this.instanceName,
      this.id,
      this.name,
      this.menu,
      this.products,
      this.dayOfWeek,
      this.mealtime,
      this.amount,
      this.image});

  factory Complex.fromJson(String str) => Complex.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Complex.fromMap(Map<String, dynamic> json) => Complex(
        entityName: json["_entityName"],
        instanceName: json["_instanceName"],
        id: json["id"],
        name: json["name"],
        dayOfWeek: json["dayOfWeek"],
        mealtime: json["mealtime"],
        amount: json["amount"],
        image: json["image"],
        menu: json["menu"] == null ? null : Menu.fromMap(json["menu"]),
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        "name": name,
        "dayOfWeek": dayOfWeek,
        "mealtime": mealtime,
        "amount": amount,
        "image": image,
        "menu": menu == null ? null : menu.toMap(),
        "products": products == null
            ? []
            : List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
