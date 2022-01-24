import 'dart:convert';

import 'package:hive/hive.dart';

part 'RepairOrderPojoLaborSpending.g.dart';

@HiveType(typeId: 33)
class RepairOrderPojoLaborSpending {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime dateAndTime;
  @HiveField(3)
  double percent;
  @HiveField(4)
  String status;

  RepairOrderPojoLaborSpending({
    this.entityName,
    this.id,
    this.dateAndTime,
    this.percent,
    this.status,
  });

  factory RepairOrderPojoLaborSpending.fromJson(String str) =>
      RepairOrderPojoLaborSpending.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RepairOrderPojoLaborSpending.fromMap(Map<String, dynamic> json) =>
      RepairOrderPojoLaborSpending(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        dateAndTime: json["dateAndTime"] == null
            ? null
            : DateTime.parse(json["dateAndTime"]),
        percent: json["percent"] == null ? null : json["percent"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "dateAndTime":
            dateAndTime == null ? null : dateAndTime.toIso8601String(),
        "percent": percent == null ? null : percent,
        "status": status == null ? null : status,
      };
}
