import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Department.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/model/util_models.dart';

import '../file_descriptor.dart';
import 'event.dart';
part 'events.g.dart';
@HiveType(typeId: 135)
class EventManagement extends AbstractBpmEntity{
  EventManagement({
    this.entityName,
    this.instanceName,
    this.id,
    this.planDateTo,
    this.initDate,
    this.initiator,
    this.eventType,
    this.actualDateTo,
    this.observer,
    this.regNumber,
    this.sevirity,
    this.eventDescription,
    this.files,
    this.comment,
    this.finishPercent,
    this.actualDateFrom,
    this.supportDocument,
    this.supervisor,
    this.planDateFrom,
    this.status,
    this.organization,
    this.department
  });
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime planDateTo;
  @HiveField(4)
  DateTime initDate;
  @HiveField(5)
  Person initiator;
  @HiveField(7)
  DateTime actualDateTo;
  @HiveField(8)
  Person observer;
  @HiveField(9)
  String regNumber;
  @HiveField(10)
  AbstractDictionary sevirity;
  @HiveField(11)
  String eventDescription;
  @HiveField(12)
  List<FileDescriptor> files;
  @HiveField(13)
  String comment;
  @HiveField(14)
  dynamic finishPercent;
  @HiveField(15)
  DateTime actualDateFrom;
  @HiveField(17)
  Person supervisor;
  @HiveField(18)
  DateTime planDateFrom;
  @HiveField(19)
  AbstractDictionary status;
  @HiveField(20)
  EventType eventType;
  @HiveField(21)
  Organization organization;
  @HiveField(22)
  Department department;
  @HiveField(24)
  SupportDoc supportDocument;

  factory EventManagement.fromJson(String str) => EventManagement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory EventManagement.fromMap(Map<String, dynamic> json) => EventManagement(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    planDateTo: json["planDateTo"] == null ? null : DateTime.parse(json["planDateTo"]),
    initDate: json["initDate"] == null ? null : DateTime.parse(json["initDate"]),
    initiator: json["initiator"] == null ? null : Person.fromMap(json["initiator"]),
    eventType: json["eventType"] == null ? null : EventType.fromMap(json["eventType"]),
    actualDateTo: json["actualDateTo"] == null ? null : DateTime.parse(json["actualDateTo"]),
    observer: json["observer"] == null ? null : Person.fromMap(json["observer"]),
    regNumber: json["regNumber"] == null ? null : json["regNumber"],
    sevirity: json["sevirity"] == null ? null : AbstractDictionary.fromMap(json["sevirity"]),
    eventDescription: json["eventDescription"] == null ? null : json["eventDescription"],
    files: json["files"] == null ? null : List<FileDescriptor>.from(json["files"].map((x) => FileDescriptor.fromMap(x))),
    comment: json["comment"] == null ? null : json["comment"],
    finishPercent: json["finishPercent"] == null ? null : json["finishPercent"],
    actualDateFrom: json["actualDateFrom"] == null ? null : DateTime.parse(json["actualDateFrom"]),
    supportDocument: json["supportDocument"] == null ? null : SupportDoc.fromMap(json["supportDocument"]),
    supervisor: json["supervisor"] == null ? null : Person.fromMap(json["supervisor"]),
    planDateFrom: json["planDateFrom"] == null ? null : DateTime.parse(json["planDateFrom"]),
    status: json["status"] == null ? null : AbstractDictionary.fromMap(json["status"]),
    organization: json["organization"] == null ? null : Organization.fromMap(json["organization"]),
    department: json["department"] == null ? null : Department.fromMap(json["department"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "planDateTo": planDateTo == null ? null : planDateTo.toIso8601String(),
    "initDate": initDate == null ? null : initDate.toIso8601String(),
    "initiator": initiator == null ? null : initiator.toMap(),
    "eventType": eventType == null ? null : eventType.toMap(),
    "actualDateTo": actualDateTo == null ? null : actualDateTo.toIso8601String(),
    "observer": observer == null ? null : observer.toMap(),
    "regNumber": regNumber == null ? null : regNumber,
    "sevirity": sevirity == null ? null : sevirity.toMap(),
    "eventDescription": eventDescription == null ? null : eventDescription,
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toMap())),
    "comment": comment == null ? null : comment,
    "finishPercent": finishPercent == null ? null : finishPercent,
    "actualDateFrom": actualDateFrom == null ? null : actualDateFrom.toIso8601String(),
    "supportDocument": supportDocument == null ? null : supportDocument,
    "supervisor": supervisor == null ? null : supervisor.toMap(),
    "planDateFrom": planDateFrom == null ? null : planDateFrom.toIso8601String(),
    "status": status == null ? null : status.toMap(),
    "organization": organization == null ? null : organization.toMap(),
    "department": department == null ? null : department.toMap(),
  };

  String toJsonCreate() {
    var map = toMapCreate();

    if(initiator != null) {
      map.putIfAbsent('issuedTo', () => initiator.toMapId());
    }
    if(supervisor != null) {
      map.putIfAbsent('supervisor', () => supervisor.toMapId());
    }
    if(observer != null) {
      map.putIfAbsent('observer', () => observer.toMapId());
    }
    if(sevirity != null) {
      map.putIfAbsent('sevirity', () => sevirity.toMap());
    }
    if(finishPercent != null) {
      map.putIfAbsent('finishPercent', () => finishPercent);
    }
    if (planDateTo != null) {
      map.putIfAbsent('planDateTo', () => formatFullRest(planDateTo));
    }
    if (planDateFrom != null) {
      map.putIfAbsent('planDateFrom', () => formatFullRest(planDateFrom));
    }
    if (actualDateTo != null) {
      map.putIfAbsent('actualDateTo', () => formatFullRest(actualDateTo));
    }
    if (actualDateFrom != null) {
      map.putIfAbsent('actualDateFrom', () => formatFullRest(actualDateFrom));
    }

    if(comment != null && comment.isNotEmpty) {
      map.putIfAbsent('comment', () => comment);
    }

    if(eventDescription != null && eventDescription.isNotEmpty) {
      map.putIfAbsent('eventDescription', () => eventDescription);
    }

    if (supportDocument != null) {
      map.putIfAbsent('supportDocument', () => supportDocument.toMapId());
    }
    return json.encode(map);
  }

  Map<String, dynamic> toMapCreate() => {
    'initDate':  formatFullRest(initDate),
    // 'eventType': eventType.toMapCode(),
    'organization': organization.toMap(),
    'department': department.toMap(),
    'files': files == null
        ? null
        : List<dynamic>.from(files.map((x) => x.toMap())),
  };
}

@HiveType(typeId: 136)
class SupportDoc {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String documentDate;
  @HiveField(4)
  String supportDocNumber;

  SupportDoc(
      {this.entityName,
        this.id,
        this.instanceName,
        this.documentDate,
        this.supportDocNumber});

  factory SupportDoc.fromJson(String str) =>
      SupportDoc.fromMap(json.decode(str));

  factory SupportDoc.fromMap(Map<String, dynamic> json) => SupportDoc(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    documentDate:
    json["documentDate"] == null ? null : json["documentDate"],
    supportDocNumber: json["supportDocNumber"] == null ? null : json["supportDocNumber"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    "_instanceName": instanceName == null ? null : instanceName,
    "_entityName": entityName == null ? null : entityName,
    "id": id == null ? null : id,
    "documentDate": documentDate == null ? null : documentDate,
    "supportDocNumber": supportDocNumber == null ? null : supportDocNumber,
  };

  Map<String, dynamic> toMapId() => {'id': id ?? ''};
}