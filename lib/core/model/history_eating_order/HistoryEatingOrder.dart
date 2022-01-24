import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/eating_menu/EatingMenus.dart';
import 'package:hse/core/model/util_models.dart';

part 'HistoryEatingOrder.g.dart';

@HiveType(typeId: 23)
class HistoryEatingOrder {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime orderDateTime;
  @HiveField(4)
  String locationName;
  @HiveField(5)
  List<EatingMenus> eatingMenus;
  @HiveField(6)
  String location;
  @HiveField(7)
  DateTime docDate;
  @HiveField(8)
  String comment;
  @HiveField(9)
  String locationGroupName;
  @HiveField(10)
  String status;
  @HiveField(11)
  String mealtimeId;
  @HiveField(12)
  bool forceAccept;
  @HiveField(13)
  String code;

  HistoryEatingOrder({
    this.entityName,
    this.instanceName,
    this.id,
    this.orderDateTime,
    this.locationName,
    this.eatingMenus,
    this.location,
    this.docDate,
    this.comment,
    this.locationGroupName,
    this.status,
    this.mealtimeId,
    this.forceAccept,
    this.code,
  });

  factory HistoryEatingOrder.fromJson(String str) =>
      HistoryEatingOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory HistoryEatingOrder.fromMap(Map<String, dynamic> json) =>
      HistoryEatingOrder(
        entityName: json['_entityName'],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        mealtimeId: json["mealtimeId"] == null ? null : json["mealtimeId"],
        code: json["code"] == null ? null : json["code"],
        forceAccept: json["forceAccept"] == null ? null : json["forceAccept"],
        orderDateTime: json["orderDateTime"] == null
            ? null
            : DateTime.parse(json["orderDateTime"]),
        locationName:
            json["locationName"] == null ? null : json["locationName"],
        eatingMenus: json["eatingMenus"] == null
            ? []
            : List<EatingMenus>.from(
                json["eatingMenus"].map((x) => EatingMenus.fromMap(x))),
        location: json["location"] == null ? null : json["location"],
        docDate:
            json["docDate"] == null ? null : DateTime.parse(json["docDate"]),
        comment: json["comment"] == null ? null : json["comment"],
        locationGroupName: json["locationGroupName"] == null
            ? null
            : json["locationGroupName"],
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toMap() => {
        "orderDateTime":
            orderDateTime == null ? null : dateTimeToString(orderDateTime),
        "locationName": locationName == null ? null : locationName,
        "eatingMenus": eatingMenus == null
            ? []
            : List<dynamic>.from(eatingMenus.map((x) => x.toMap())),
        "location": location == null ? null : location,
        "mealtimeId": mealtimeId == null ? null : mealtimeId,
        "forceAccept": forceAccept == null ? null : forceAccept,
        "code": code == null ? null : code,
        "locationGroupName":
            locationGroupName == null ? null : locationGroupName,
      };

  Map<String, dynamic> toFullMap() => {
        "orderDateTime":
            orderDateTime == null ? null : dateTimeToString(orderDateTime),
        "locationName": locationName == null ? null : locationName,
        "id": id == null ? null : id,
        "eatingMenus": eatingMenus == null
            ? []
            : List<dynamic>.from(eatingMenus.map((x) => x.toMap())),
        "location": location == null ? null : location,
        "code": code == null ? null : code,
        "mealtimeId": mealtimeId == null ? null : mealtimeId,
        "forceAccept": forceAccept == null ? null : forceAccept,
        "locationGroupName":
            locationGroupName == null ? null : locationGroupName,
      };
}
