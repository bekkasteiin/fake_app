import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/util_models.dart';

part 'LaborSpending.g.dart';

@HiveType(typeId: 28)
class LaborSpending {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime factEndDate;
  @HiveField(3)
  double factObject;
  @HiveField(4)
  double percentCompletion;
  @HiveField(5)
  String status;

  LaborSpending({
    this.entityName,
    this.id,
    this.factEndDate,
    this.factObject,
    this.percentCompletion,
    this.status,
  });

  factory LaborSpending.fromJson(String str) =>
      LaborSpending.fromMap(json.decode(str));

  factory LaborSpending.fromMap(Map<String, dynamic> json) => LaborSpending(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        factEndDate: json["factEndDate"] == null
            ? null
            : DateTime.parse(json["factEndDate"]),
        factObject: json["factObject"] == null ? null : json["factObject"],
        percentCompletion: json["percentCompletion"] == null
            ? null
            : json["percentCompletion"],
        status: json["status"] == null ? null : json["status"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "factEndDate":
            factEndDate == null ? null : dateTimeToString(factEndDate),
        "factObject": factObject == null ? "" : factObject,
        "percentCompletion":
            percentCompletion == null ? "0" : percentCompletion,
        "status": status == null ? "IS_NEW" : status,
      };
}
