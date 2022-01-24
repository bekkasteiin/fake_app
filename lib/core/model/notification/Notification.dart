import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/util_models.dart';

import 'Person.dart';

part 'Notification.g.dart';

@HiveType(typeId: 49)
class Notifications extends HiveObject {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String notification;
  @HiveField(3)
  Person person;
  @HiveField(4)
  bool isCloseable;
  @HiveField(5)
  String notificationTypeCode;
  @HiveField(6)
  DateTime createTs;
  @HiveField(7)
  String status;
  @HiveField(8)
  String title;

  Notifications(
      {this.entityName,
      this.id,
      this.notification,
      this.person,
      this.isCloseable,
      this.status,
      this.title,
      this.notificationTypeCode,
      this.createTs});

  factory Notifications.fromJson(String str) =>
      Notifications.fromMap(json.decode(str));

  factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        notification: json["message"] == null ? null : json["message"],
        person: json["fromPersonPojo"] == null
            ? null
            : Person.fromMap(json["fromPersonPojo"]),
        isCloseable: json["isCloseable"] == null ? true : json["isCloseable"],
        notificationTypeCode: json["notificationTypeCode"] == null
            ? true
            : json["notificationTypeCode"],
        status: json["status"] == null ? null : json["status"],
        createTs:
            json["createTs"] == null ? null : DateTime.parse(json["createTs"]),
        title: json["title"] == null ? null : json["title"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "message": notification == null ? null : notification,
        "fromPersonPojo": person == null ? null : person.toMap(),
        "isCloseable": isCloseable == null ? null : isCloseable,
        "notificationTypeCode":
            notificationTypeCode == null ? null : notificationTypeCode,
        "createTs": createTs == null ? null : dateTimeToString(createTs),
        "status": status == null ? null : status,
        "title": title == null ? null : title,
      };
}
