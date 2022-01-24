import 'dart:convert';

import 'package:hive/hive.dart';

import 'CarOrder.dart';

part 'CarOrderGroupped.g.dart';

@HiveType(typeId: 65)
class CarOrderGroupped {
  @HiveField(0)
  final String instanceName;
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String month;
  @HiveField(3)
  final List<CarOrder> list;

  CarOrderGroupped({
    this.instanceName,
    this.id,
    this.month,
    this.list,
  });

  fromJson(String str) => CarOrderGroupped.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CarOrderGroupped.fromMap(Map<String, dynamic> json) =>
      CarOrderGroupped(
        instanceName: json["_instanceName"],
        id: json["id"],
        month: json["month"],
        list: List<CarOrder>.from(json["list"].map((x) => CarOrder.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_instanceName": instanceName,
        "id": id,
        "month": month,
        "list": List<dynamic>.from(list.map((x) => x.toMap())),
      };
}
