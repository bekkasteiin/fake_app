import 'dart:convert';

import 'package:hive/hive.dart';

import 'TransportOrderPojoWork.dart';

part 'TransportOrderPojo.g.dart';

@HiveType(typeId: 38)
class TransportOrderPojo {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String code;
  @HiveField(3)
  TransportOrderPojoWork work;
  @HiveField(4)
  String shift;
  @HiveField(5)
  String comment;
  @HiveField(6)
  DateTime orderDate;

  TransportOrderPojo({
    this.entityName,
    this.id,
    this.code,
    this.work,
    this.shift,
    this.comment,
    this.orderDate,
  });

  factory TransportOrderPojo.fromJson(String str) =>
      TransportOrderPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransportOrderPojo.fromMap(Map<String, dynamic> json) =>
      TransportOrderPojo(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        work: json["work"] == null
            ? null
            : TransportOrderPojoWork.fromMap(json["work"]),
        shift: json["shift"] == null ? "" : json["shift"],
        comment: json["comment"] == null ? null : json["comment"],
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
        "comment": comment == null ? null : comment,
        "orderDate": orderDate == null ? null : orderDate.toIso8601String(),
      };
}
