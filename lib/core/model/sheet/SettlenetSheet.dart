import 'dart:convert';

import 'package:hive/hive.dart';

part 'SettlenetSheet.g.dart';

@HiveType(typeId: 58)
class SettlenetSheet {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  String period;
  @HiveField(5)
  String fileId;
  @HiveField(6)
  bool seen;

  SettlenetSheet(
      {this.entityName,
      this.instanceName,
      this.id,
      this.date,
      this.period,
      this.fileId,
      this.seen});

  fromJson(String str) => SettlenetSheet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SettlenetSheet.fromMap(Map<String, dynamic> json) => SettlenetSheet(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        period: json["period"] == null ? null : json["period"],
        fileId: json["fileId"] == null ? null : json["fileId"],
        seen: json["seen"] == null ? null : json["seen"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "date": date == null ? null : date.toIso8601String(),
        "period": period == null ? null : period,
        "fileId": fileId == null ? null : fileId,
        "seen": seen == null ? null : seen,
      };
}
