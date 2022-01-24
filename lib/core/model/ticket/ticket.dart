// To parse this JSON data, do
//
//     final ticket = ticketFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Person.dart';

part 'ticket.g.dart';

@HiveType(typeId: 131)
class Ticket {
  Ticket({
    this.entityName,
    this.instanceName,
    this.id,
    this.issuedDate,
    this.qr,
    this.ticketNumber,
    this.code,
    this.issuedBy,
    this.type,
    this.incident,
    this.status,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime issuedDate;
  @HiveField(4)
  String qr;
  @HiveField(5)
  String ticketNumber;
  @HiveField(6)
  String code;
  @HiveField(7)
  Person issuedBy;
  @HiveField(8)
  String type;
  @HiveField(9)
  String incident;
  @HiveField(10)
  String status;

  factory Ticket.fromJson(String str) => Ticket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    issuedDate: json["issuedDate"] == null ? null : DateTime.parse(json["issuedDate"]),
    qr: json["qr"] == null ? null : json["qr"],
    ticketNumber: json["ticketNumber"] == null ? null : json["ticketNumber"],
    code: json["code"] == null ? null : json["code"],
    issuedBy: json["issuedBy"] == null ? null : Person.fromMap(json["issuedBy"]),
    type: json["type"] == null ? null : json["type"],
    incident: json["incident"] == null ? null : json["incident"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "issuedDate": issuedDate == null ? null : issuedDate.toIso8601String(),
    "qr": qr == null ? null : qr,
    "ticketNumber": ticketNumber == null ? null : ticketNumber,
    "code": code == null ? null : code,
    "issuedBy": issuedBy == null ? null : issuedBy.toMap(),
    "type": type == null ? null : type,
    "incident": incident == null ? null : incident,
    "status": status == null ? null : status,
  };
}

@HiveType(typeId: 130)
class TicketResponse {
  TicketResponse({
    this.ticket,
    this.status,
  });

  @HiveField(0)
  Ticket ticket;
  @HiveField(1)
  bool status;

  factory TicketResponse.fromJson(String str) => TicketResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TicketResponse.fromMap(Map<String, dynamic> json) => TicketResponse(
    ticket: json["ticket"] == null ? null : Ticket.fromMap(json["ticket"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "ticket": ticket == null ? null : ticket.toMap(),
    "status": status == null ? null : status,
  };
}

