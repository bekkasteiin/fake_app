import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Department.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
import 'package:hse/core/model/message/object_name.dart';
import '../file_descriptor.dart';

import '../util_models.dart';
import 'observation.dart';

part 'bsa.g.dart';

@HiveType(typeId: 126)
class BehaviorAudit extends AbstractBpmEntity {
  BehaviorAudit(
      {this.entityName,
      this.instanceName,
      this.id,
      this.date,
      this.regDateTime,
      this.watchedQuantity,
      this.initiator,
      this.empComment,
      this.actionDescription,
      this.duration,
      this.regNumber,
      this.sevirity,
      this.organization,
      this.observations,
      this.objectName,
      this.files,
      this.comment,
      this.responsibles,
      this.department,
      this.category,
      this.status,
      this.workType,
      this.planDate,
      this.filled,
      this.isDone});

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime date;
  @HiveField(4)
  DateTime regDateTime;
  @HiveField(5)
  int watchedQuantity;
  @HiveField(6)
  Person initiator;
  @HiveField(7)
  String empComment;
  @HiveField(8)
  String actionDescription;
  @HiveField(9)
  int duration;
  @HiveField(10)
  String regNumber;
  @HiveField(11)
  AbstractDictionary sevirity;
  @HiveField(12)
  Organization organization;
  @HiveField(13)
  List<Observation> observations;
  @HiveField(14)
  ObjectName objectName;
  @HiveField(15)
  List<FileDescriptor> files;
  @HiveField(16)
  String comment;
  @HiveField(17)
  List<Person> responsibles;
  @HiveField(18)
  Department department;
  @HiveField(19)
  AbstractDictionary category;
  @HiveField(20)
  AbstractDictionary status;
  @HiveField(21)
  String workType;
  @HiveField(22)
  DateTime planDate;
  @HiveField(23)
  bool filled;
  @HiveField(24)
  bool isDone;

  factory BehaviorAudit.fromJson(String str) =>
      BehaviorAudit.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BehaviorAudit.fromMap(Map<String, dynamic> json) => BehaviorAudit(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        planDate:
            json["planDate"] == null ? null : DateTime.parse(json["planDate"]),
        regDateTime: json["regDateTime"] == null
            ? null
            : DateTime.parse(json["regDateTime"]),
        watchedQuantity:
            json["watchedQuantity"] == null ? null : json["watchedQuantity"],
        initiator: json["initiator"] == null
            ? null
            : Person.fromMap(json["initiator"]),
        empComment: json["empComment"] == null ? null : json["empComment"],
        workType: json["workType"] == null ? null : json["workType"],
        actionDescription: json["actionDescription"] == null
            ? null
            : json["actionDescription"],
        duration: json["duration"] == null ? null : json["duration"],
        regNumber: json["regNumber"] == null ? null : json["regNumber"],
        sevirity: json["sevirity"] == null
            ? null
            : AbstractDictionary.fromMap(json["sevirity"]),
        organization: json["organization"] == null
            ? null
            : Organization.fromMap(json["organization"]),
        observations: json["observations"] == null
            ? null
            : List<Observation>.from(
                json["observations"].map((x) => Observation.fromMap(x))),
        objectName: json["objectName"] == null
            ? null
            : ObjectName.fromMap(json["objectName"]),
        files: json["files"] == null
            ? null
            : List<FileDescriptor>.from(
                json["files"].map((x) => FileDescriptor.fromMap(x))),
        comment: json["comment"] == null ? null : json["comment"],
        responsibles: json["responsibles"] == null
            ? null
            : List<Person>.from(
                json["responsibles"].map((x) => Person.fromMap(x))),
        department: json["department"] == null
            ? null
            : Department.fromMap(json["department"]),
        category: json["category"] == null
            ? null
            : AbstractDictionary.fromMap(json["category"]),
        status: json["status"] == null
            ? null
            : AbstractDictionary.fromMap(json["status"]),
        isDone: json["watchedQuantity"] == null ? false : true,
        filled: json["watchedQuantity"] == null ? false : true,
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "date": date == null ? null : date.toIso8601String(),
        "planDate": planDate == null ? null : planDate.toIso8601String(),
        "regDateTime":
            regDateTime == null ? null : regDateTime.toIso8601String(),
        "watchedQuantity": watchedQuantity == null ? null : watchedQuantity,
        "initiator": initiator == null ? null : initiator.toMap(),
        "empComment": empComment == null ? null : empComment,
        "workType": workType == null ? null : workType,
        "actionDescription":
            actionDescription == null ? null : actionDescription,
        "duration": duration == null ? null : duration,
        "regNumber": regNumber == null ? null : regNumber,
        "sevirity": sevirity == null ? null : sevirity.toMap(),
        "organization": organization == null ? null : organization.toMap(),
        "observations": observations == null
            ? null
            : List<dynamic>.from(observations.map((x) => x.toMap())),
        "objectName": objectName == null ? null : objectName.toMap(),
        "files": files == null
            ? null
            : List<dynamic>.from(files.map((x) => x.toMap())),
        "comment": comment == null ? null : comment,
        "responsibles": responsibles == null
            ? null
            : List<dynamic>.from(responsibles.map((x) => x.toMap())),
        "department": department == null ? null : department.toMap(),
        "category": category == null ? null : category.toMap(),
        "status": status == null ? null : status.toMap(),
      };

  String toJsonCreate() {
    var map = toMapCreate();
    if (comment != null) {
      map.putIfAbsent('comment', () => comment);
    }
    if (workType != null) {
      map.putIfAbsent('workType', () => workType);
    }
    if (empComment != null) {
      map.putIfAbsent('empComment', () => empComment);
    }
    if (actionDescription != null) {
      map.putIfAbsent('actionDescription', () => actionDescription);
    }
    if (duration != null) {
      map.putIfAbsent('duration', () => duration);
    }
    if (watchedQuantity != null) {
      map.putIfAbsent('watchedQuantity', () => watchedQuantity);
    }
    if (observations != null && observations.isNotEmpty) {
      map.putIfAbsent('observations',
          () => List<dynamic>.from(observations.map((x) => x.toMap())));
    }
    if (responsibles != null && responsibles.isNotEmpty) {
      map.putIfAbsent('responsibles',
          () => List<dynamic>.from(responsibles.map((x) => x.toMap())));
    }
    if (planDate != null) {
      map.putIfAbsent('planDate', () => formatFullRest(planDate));
    }
    if (category != null) {
      map.putIfAbsent('category', () => category.toMap());
    }
    if(regNumber != null) {
      map.putIfAbsent('regNumber', () => regNumber);
    }
    return json.encode(map);
  }

  Map<String, dynamic> toMapCreate() => {
        'id': id ?? '',
        'organization': organization.toMap(),
        'date': formatFullRest(date),
        'objectName': objectName.toMap(),
        'files': files == null
            ? null
            : List<dynamic>.from(files.map((x) => x.toMap())),
        'department': department.toMap(),
      };
}
