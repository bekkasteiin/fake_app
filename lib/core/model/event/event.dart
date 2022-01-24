// To parse this JSON data, do
//
//     final eventEntity = eventEntityFromMap(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/viewmodels/bpm_models/abstracn_bpm_model.dart';

import '../util_models.dart';

part 'event.g.dart';

@HiveType(typeId: 133)
class EventEntity extends AbstractBpmEntity {
  EventEntity({
    this.entityName,
    this.instanceName,
    this.id,
    this.issuedTo,
    this.initDate,
    this.initiator,
    this.eventType,
    this.regNumber,
    this.comment,
    this.commentNid,
    this.nationalId
  });
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  Person issuedTo;
  @HiveField(4)
  DateTime initDate;
  @HiveField(5)
  Person initiator;
  @HiveField(6)
  EventType eventType;
  @HiveField(7)
  String regNumber;
  @HiveField(8)
  String comment;
  @HiveField(9)
  String nationalId;
  @HiveField(10)
  String commentNid;

  factory EventEntity.fromJson(String str) => EventEntity.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventEntity.fromMap(Map<String, dynamic> json) => EventEntity(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    issuedTo: json["issuedTo"] == null ? null : Person.fromMap(json["issuedTo"]),
    initDate: json["initDate"] == null ? null : DateTime.parse(json["initDate"]),
    initiator: json["initiator"] == null ? null : Person.fromMap(json["initiator"]),
    eventType: json["eventType"] == null ? null : EventType.fromMap(json["eventType"]),
    regNumber: json["regNumber"] == null ? null : json["regNumber"],
    comment: json["comment"] == null ? null : json["comment"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "issuedTo": issuedTo == null ? null : issuedTo.toMap(),
    "initDate": initDate == null ? null : initDate.toIso8601String(),
    "initiator": initiator == null ? null : initiator.toMap(),
    "eventType": eventType == null ? null : eventType.toMap(),
    "regNumber": regNumber == null ? null : regNumber,
    "comment": comment == null ? null : comment,
  };
  String toJsonCreate() {
    var map = toMapCreate();

    if(issuedTo != null) {
      map.putIfAbsent('issuedTo', () => issuedTo.toMapId());
    }

    if(comment != null && comment.isNotEmpty) {
      map.putIfAbsent('comment', () => comment);
    }

    if(commentNid != null && commentNid.isNotEmpty) {
      map.putIfAbsent('commentNid', () => commentNid);
    }

    if(nationalId != null && nationalId.isNotEmpty) {
      map.putIfAbsent('nationalId', () => nationalId);
    }
    return json.encode(map);
  }

  Map<String, dynamic> toMapCreate() => {
    "initDate":  formatFullRest(initDate),
    "eventType": eventType.toMapCode(),
  };

}

@HiveType(typeId: 134)
class EventType {
  EventType({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.color,
    this.langValue,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String color;
  @HiveField(5)
  String langValue;

  factory EventType.fromJson(String str) => EventType.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventType.fromMap(Map<String, dynamic> json) => EventType(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    code: json["code"] == null ? null : json["code"],
    color: json["color"] == null ? null : json["color"],
    langValue: json["langValue"] == null ? null : json["langValue"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "code": code == null ? null : code,
    "color": color == null ? null : color,
    "langValue": langValue == null ? null : langValue,
  };

  Map<String, dynamic> toMapCode() => {
    "code": code,
  };
}

