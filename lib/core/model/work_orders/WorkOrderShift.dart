import 'dart:convert';

import 'package:hive/hive.dart';

import 'WorkOrderShiftWork.dart';

part 'WorkOrderShift.g.dart';

@HiveType(typeId: 44)
class WorkOrderShift {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String code;
  @HiveField(3)
  WorkOrderShiftWork work;
  @HiveField(4)
  String shift;
  @HiveField(5)
  DateTime orderDate;

  WorkOrderShift({
    this.entityName,
    this.id,
    this.code,
    this.work,
    this.shift,
    this.orderDate,
  });

  factory WorkOrderShift.fromJson(String str) =>
      WorkOrderShift.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkOrderShift.fromMap(Map<String, dynamic> json) => WorkOrderShift(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        work: json["work"] == null
            ? null
            : WorkOrderShiftWork.fromMap(json["work"]),
        shift: json["shift"] == null ? null : json["shift"],
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "work": work == null ? null : work.toMap(),
        "shift": shift == null ? null : shift,
        "orderDate": orderDate == null ? null : orderDate.toIso8601String(),
      };
}
