

// To parse this JSON data, do
//
//     final ticketHistory = ticketHistoryFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';

part 'ticket_history.g.dart';

@HiveType(typeId: 132)
class TicketHistory extends AbstractBpmEntity {
  TicketHistory({
    this.entityName,
    this.instanceName,
    this.id,
    this.ticketNumber,
    this.color,
    this.issuedBy,
    this.type,
    this.actionDate,
    this.incident,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String ticketNumber;
  @HiveField(4)
  String color;
  @HiveField(5)
  Person issuedBy;
  @HiveField(6)
  String type;
  @HiveField(7)
  DateTime actionDate;
  @HiveField(8)
  String incident;

  factory TicketHistory.fromJson(String str) => TicketHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketHistory.fromMap(Map<String, dynamic> json) => TicketHistory(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    ticketNumber: json["ticketNumber"] == null ? null : json["ticketNumber"],
    color: json["color"] == null ? null : json["color"],
    issuedBy: json["issuedBy"] == null ? null : Person.fromMap(json["issuedBy"]),
    type: json["type"] == null ? null : json["type"],
    actionDate: json["actionDate"] == null ? null : DateTime.parse(json["actionDate"]),
    incident: json["incident"] == null ? null : json["incident"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "ticketNumber": ticketNumber == null ? null : ticketNumber,
    "color": color == null ? null : color,
    "issuedBy": issuedBy == null ? null : issuedBy.toMap(),
    "type": type == null ? null : type,
    "actionDate": actionDate == null ? null : actionDate.toIso8601String(),
    "incident": incident == null ? null : incident,
  };
}

