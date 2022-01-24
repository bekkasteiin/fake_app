import 'dart:convert';

import 'package:hive/hive.dart';

part 'Placement.g.dart';

@HiveType(typeId: 52)
class Placement {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime endDate;
  @HiveField(3)
  String hotel;
  @HiveField(4)
  String location;
  @HiveField(5)
  String room;
  @HiveField(6)
  DateTime startDate;

  Placement({
    this.entityName,
    this.id,
    this.endDate,
    this.hotel,
    this.location,
    this.room,
    this.startDate,
  });

  factory Placement.fromJson(String str) => Placement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Placement.fromMap(Map<String, dynamic> json) => Placement(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        endDate:
            json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
        hotel: json["hotel"] == null ? null : json["hotel"],
        location: json["location"] == null ? null : json["location"],
        room: json["room"] == null ? null : json["room"],
        startDate: json["startDate"] == null
            ? null
            : DateTime.parse(json["startDate"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "endDate": endDate == null ? null : endDate.toIso8601String(),
        "hotel": hotel == null ? null : hotel,
        "location": location == null ? null : location,
        "room": room == null ? null : room,
        "startDate": startDate == null ? null : startDate.toIso8601String(),
      };
}
