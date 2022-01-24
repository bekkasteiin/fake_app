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
part 'risks.g.dart';
@HiveType(typeId: 128)
class RisksManagement extends AbstractBpmEntity{
  RisksManagement({
    this.entityName,
    this.instanceName,
    this.id,
    this.assessmentVersion,
    this.level,
    this.initDate,
    this.probability,
    this.initiator,
    this.regDate,
    this.riskManageability,
    this.dangerousCategory,
    this.dangerousSource,
    this.actionType,
    this.regNumber,
    this.organization,
    this.objectName,
    this.consequences,
    this.files,
    this.comment,
    this.department,
    this.status,
  });
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  int assessmentVersion;
  @HiveField(4)
  AbstractDictionary level;
  @HiveField(5)
  DateTime initDate;
  @HiveField(6)
  AbstractDictionary probability;
  @HiveField(7)
  Person initiator;
  @HiveField(8)
  DateTime regDate;
  @HiveField(9)
  List<AbstractDictionary> riskManageability;
  @HiveField(10)
  AbstractDictionary dangerousCategory;
  @HiveField(11)
  AbstractDictionary dangerousSource;
  @HiveField(12)
  AbstractDictionary actionType;
  @HiveField(13)
  String regNumber;
  @HiveField(14)
  Organization organization;
  @HiveField(16)
  AbstractDictionary consequences;
  @HiveField(17)
  List<FileDescriptor> files;
  @HiveField(18)
  String comment;
  @HiveField(19)
  Department department;
  @HiveField(20)
  AbstractDictionary status;
  @HiveField(21)
  ObjectName objectName;

  factory RisksManagement.fromJson(String str) =>
      RisksManagement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RisksManagement.fromMap(Map<String, dynamic> json) => RisksManagement(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    assessmentVersion: json["assessmentVersion"] == null ? null : json["assessmentVersion"],
    level: json["level"] == null ? null : AbstractDictionary.fromMap(json["level"]),
    initDate: json["initDate"] == null ? null : DateTime.parse(json["initDate"]),
    probability: json["probability"] == null ? null : AbstractDictionary.fromMap(json["probability"]),
    initiator: json["initiator"] == null ? null : Person.fromMap(json["initiator"]),
    regDate: json["regDate"] == null ? null : DateTime.parse(json["regDate"]),
    riskManageability: json["riskManageability"] == null ? null : List<AbstractDictionary>.from(json["riskManageability"].map((x) => AbstractDictionary.fromMap(x))),
    dangerousCategory: json["dangerousCategory"] == null ? null : AbstractDictionary.fromMap(json["dangerousCategory"]),
    dangerousSource: json["dangerousSource"] == null ? null : AbstractDictionary.fromMap(json["dangerousSource"]),
    actionType: json["actionType"] == null ? null : AbstractDictionary.fromMap(json["actionType"]),
    regNumber: json["regNumber"] == null ? null : json["regNumber"],
    organization: json["organization"] == null ? null : Organization.fromMap(json["organization"]),
    objectName: json["objectName"] == null ? null : ObjectName.fromMap(json["objectName"]),
    consequences: json["consequences"] == null ? null : AbstractDictionary.fromMap(json["consequences"]),
    files: json["files"] == null ? null : List<FileDescriptor>.from(json["files"].map((x) => FileDescriptor.fromMap(x))),
    comment: json["comment"] == null ? null : json["comment"],
    department: json["department"] == null ? null : Department.fromMap(json["department"]),
    status: json["status"] == null ? null : AbstractDictionary.fromMap(json["status"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "assessmentVersion": assessmentVersion == null ? null : assessmentVersion,
    "level": level == null ? null : level.toMap(),
    "initDate": initDate == null ? null : initDate.toIso8601String(),
    "probability": probability == null ? null : probability.toMap(),
    "initiator": initiator == null ? null : initiator.toMap(),
    "regDate": regDate == null ? null : regDate.toIso8601String(),
    "riskManageability": riskManageability == null ? null : List<dynamic>.from(riskManageability.map((x) => x.toMap())),
    "dangerousCategory": dangerousCategory == null ? null : dangerousCategory.toMap(),
    "dangerousSource": dangerousSource == null ? null : dangerousSource.toMap(),
    "actionType": actionType == null ? null : actionType.toMap(),
    "regNumber": regNumber == null ? null : regNumber,
    "organization": organization == null ? null : organization.toMap(),
    "objectName": objectName == null ? null : objectName.toMap(),
    "consequences": consequences == null ? null : consequences.toMap(),
    "files": files == null ? null : List<dynamic>.from(files.map((x) => x.toMap())),
    "comment": comment == null ? null : comment,
    "department": department == null ? null : department.toMap(),
    "status": status == null ? null : status.toMap(),
  };

  String toJsonCreate() {
    var map = toMapCreate();
    if (comment != null) {
      map.putIfAbsent('comment', () => comment);
    }
    if (riskManageability != null && riskManageability.isNotEmpty) {
      map.putIfAbsent('riskManageability',
              () => List<dynamic>.from(riskManageability.map((x) => x.toMap())));
    }
    if (probability != null) {
      map.putIfAbsent('probability', () => probability.toMap());
    }
    if (dangerousCategory != null) {
      map.putIfAbsent('dangerousCategory', () => dangerousCategory.toMap());
    }
    if (dangerousSource != null) {
      map.putIfAbsent('dangerousSource', () => dangerousSource.toMap());
    }
    if (actionType != null) {
      map.putIfAbsent('actionType', () => actionType.toMap());
    }
    if (consequences != null) {
      map.putIfAbsent('consequences', () => consequences.toMap());
    }
    if (status != null) {
      map.putIfAbsent('status', () => status.toMap());
    }
    if(regNumber != null) {
      map.putIfAbsent('regNumber', () => regNumber);
    }
    if (regDate != null) {
      map.putIfAbsent('regDate', () => formatFullRest(regDate));
    }
    return json.encode(map);
  }

  Map<String, dynamic> toMapCreate() => {
    'id': id ?? '',
    'organization': organization.toMap(),
    'initDate': formatFullRest(initDate),
    'objectName': objectName.toMap(),
    'files': files == null
        ? null
        : List<dynamic>.from(files.map((x) => x.toMap())),
    'department': department.toMap(),
  };
}