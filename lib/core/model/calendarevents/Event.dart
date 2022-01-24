import 'dart:convert';

import 'package:hive/hive.dart';

part 'Event.g.dart';

@HiveType(typeId: 67)
class Event {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime endDate;
  @HiveField(3)
  String description;
  @HiveField(4)
  String title;
  @HiveField(5)
  String ppeName;
  @HiveField(6)
  String typeCode;

  Event({
    this.entityName,
    this.id,
    this.endDate,
    this.description,
    this.title,
    this.ppeName,
    this.typeCode,
  });

  factory Event.fromJson(String str) => Event.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Event.fromMap(Map<String, dynamic> json) => Event(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        description: json["description"] == null ? null : json["description"],
        title: json["title"] == null ? null : json["title"],
        ppeName: json["ppeName"] == null ? null : json["ppeName"],
        typeCode: json["typeCode"] == null ? null : json["typeCode"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "endDate": endDate == null ? null : endDate.toIso8601String(),
        "description": description == null ? null : description,
        "title": title == null ? null : title,
        "ppeName": ppeName == null ? null : ppeName,
        "typeCode": typeCode == null ? null : typeCode,
      };
}
