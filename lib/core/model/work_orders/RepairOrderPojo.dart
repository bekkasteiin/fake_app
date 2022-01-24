import 'dart:convert';

import 'package:hive/hive.dart';

import 'RepairOrderPojoLaborSpending.dart';
import 'RepairOrderPojoWork.dart';

part 'RepairOrderPojo.g.dart';

@HiveType(typeId: 32)
class RepairOrderPojo {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String number;
  @HiveField(3)
  String repairOrderId;
  @HiveField(4)
  List<RepairOrderPojoLaborSpending> laborSpending;
  @HiveField(5)
  RepairOrderPojoWork work;
  @HiveField(6)
  String repairType;
  @HiveField(7)
  String comment;
  @HiveField(8)
  String asset;
  @HiveField(9)
  DateTime orderDate;
  @HiveField(10)
  DateTime planEndDate;

  RepairOrderPojo({
    this.entityName,
    this.id,
    this.number,
    this.repairOrderId,
    this.laborSpending,
    this.work,
    this.repairType,
    this.comment,
    this.asset,
    this.orderDate,
    this.planEndDate,
  });

  factory RepairOrderPojo.fromJson(String str) =>
      RepairOrderPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RepairOrderPojo.fromMap(Map<String, dynamic> json) => RepairOrderPojo(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        number: json["number"] == null ? null : json["number"],
        repairOrderId:
            json["repairOrderId"] == null ? null : json["repairOrderId"],
        laborSpending: json["laborSpending"] == null
            ? []
            : List<RepairOrderPojoLaborSpending>.from(json["laborSpending"]
                .map((x) => RepairOrderPojoLaborSpending.fromMap(x))),
        work: json["work"] == null
            ? null
            : RepairOrderPojoWork.fromMap(json["work"]),
        repairType: json["repairType"] == null ? null : json["repairType"],
        comment: json["comment"] == null ? null : json["comment"],
        asset: json["asset"] == null ? null : json["asset"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        planEndDate: json["planEndDate"] == null
            ? null
            : DateTime.parse(json["planEndDate"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "number": number == null ? null : number,
        "repairOrderId": repairOrderId == null ? null : repairOrderId,
        "laborSpending": laborSpending == null
            ? []
            : List<dynamic>.from(laborSpending.map((x) => x.toMap())),
        "work": work == null ? null : work.toMap(),
        "repairType": repairType == null ? null : repairType,
        "comment": comment == null ? null : comment,
        "asset": asset == null ? null : asset,
        "orderDate": orderDate == null ? null : orderDate.toIso8601String(),
        "planEndDate":
            planEndDate == null ? null : planEndDate.toIso8601String(),
      };
}
