import 'dart:convert';

import 'package:hive/hive.dart';

part 'WorkOrderPojoLaborSpending.g.dart';

@HiveType(typeId: 42)
class WorkOrderPojoLaborSpending {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double factObject;
  @HiveField(3)
  DateTime factEndDate;
  @HiveField(4)
  double percentCompletion;
  @HiveField(5)
  String status;

  WorkOrderPojoLaborSpending({
    this.entityName,
    this.id,
    this.factObject,
    this.factEndDate,
    this.percentCompletion,
    this.status,
  });

  factory WorkOrderPojoLaborSpending.fromJson(String str) =>
      WorkOrderPojoLaborSpending.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkOrderPojoLaborSpending.fromMap(Map<String, dynamic> json) =>
      WorkOrderPojoLaborSpending(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        factObject: json["factObject"] == null ? null : json["factObject"],
        factEndDate: json["factEndDate"] == null
            ? null
            : DateTime.parse(json["factEndDate"]),
        percentCompletion: json["percentCompletion"] == null
            ? null
            : json["percentCompletion"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "factObject": factObject == null ? null : factObject,
        "factEndDate":
            factEndDate == null ? null : factEndDate.toIso8601String(),
        "percentCompletion":
            percentCompletion == null ? null : percentCompletion,
        "status": status == null ? null : status,
      };
}
