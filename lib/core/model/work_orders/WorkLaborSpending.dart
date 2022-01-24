import 'dart:convert';

import 'package:hive/hive.dart';

part 'WorkLaborSpending.g.dart';

@HiveType(typeId: 40)
class WorkLaborSpending {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime dateAndTime;
  @HiveField(3)
  double milage;
  @HiveField(4)
  double tripQuantity;
  @HiveField(5)
  double turnover;
  @HiveField(6)
  String status;
  @HiveField(7)
  String uom;
  @HiveField(8)
  double fact;

  WorkLaborSpending({
    this.entityName,
    this.id,
    this.dateAndTime,
    this.milage,
    this.tripQuantity,
    this.turnover,
    this.status,
    this.uom,
    this.fact,
  });

  factory WorkLaborSpending.fromJson(String str) =>
      WorkLaborSpending.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkLaborSpending.fromMap(Map<String, dynamic> json) =>
      WorkLaborSpending(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        dateAndTime: json["dateAndTime"] == null
            ? null
            : DateTime.parse(json["dateAndTime"]),
        milage: json["milage"] == null ? null : json["milage"],
        tripQuantity:
            json["tripQuantity"] == null ? null : json["tripQuantity"],
        turnover: json["turnover"] == null ? null : json["turnover"],
        status: json["status"] == null ? null : json["status"],
        uom: json["uom"] == null ? null : json["uom"],
        fact: json["fact"] == null ? null : json["fact"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "dateAndTime":
            dateAndTime == null ? null : dateAndTime.toIso8601String(),
        "milage": milage == null ? null : milage,
        "tripQuantity": tripQuantity == null ? null : tripQuantity,
        "turnover": turnover == null ? null : turnover,
        "status": status == null ? null : status,
        "uom": uom == null ? null : uom,
        "fact": fact == null ? null : fact,
      };
}
