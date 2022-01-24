import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Department.dart';
import 'package:hse/core/model/assignment/Organization.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/bpm/abstract_bmp_entity.dart';
import 'package:hse/core/model/file_descriptor.dart';
import 'package:hse/core/model/message/condition_category.dart';
import 'dart:convert';
import '../util_models.dart';
import 'object_name.dart';
import 'message_dictionary.dart';

part 'message.g.dart';

@HiveType(typeId: 121)
class Message extends AbstractBpmEntity {
  Message({
    this.entityName,
    this.instanceName,
    this.id,
    this.regDateTime,
    this.initiator,
    this.dangerousConditionCategories,
    this.violatedEmployees,
    this.initiatorPrivacy,
    this.requestNumber,
    this.initDateTime,
    this.sevirity,
    this.otherViolationComment,
    this.organization,
    this.objectName,
    this.files,
    this.comment,
    this.takenAction,
    this.category,
    this.department,
    this.dangerousActions,
    this.status,
  });
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  DateTime regDateTime;
  @HiveField(4)
  Person initiator;
  @HiveField(5)
  List<ConditionCategory> dangerousConditionCategories;
  @HiveField(6)
  List<Person> violatedEmployees;
  @HiveField(7)
  bool initiatorPrivacy;
  @HiveField(8)
  String requestNumber;
  @HiveField(9)
  DateTime initDateTime;
  @HiveField(10)
  AbstractDictionary sevirity;
  @HiveField(11)
  String otherViolationComment;
  @HiveField(12)
  Organization organization;
  @HiveField(13)
  ObjectName objectName;
  @HiveField(14)
  List<FileDescriptor> files;
  @HiveField(15)
  String comment;
  @HiveField(16)
  AbstractDictionary takenAction;
  @HiveField(17)
  AbstractDictionary category;
  @HiveField(18)
  Department department;
  @HiveField(19)
  List<AbstractDictionary> dangerousActions;
  @HiveField(20)
  AbstractDictionary status;

  factory Message.fromJson(String str) => Message.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Message.fromMap(Map<String, dynamic> json) => Message(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName:
    json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    regDateTime: json["regDateTime"] == null
        ? null
        : DateTime.parse(json["regDateTime"]),
    initiator: json["initiator"] == null
        ? null
        : Person.fromMap(json["initiator"]),
    dangerousConditionCategories: json["dangerousConditionCategories"] ==
        null
        ? null
        : List<ConditionCategory>.from(json["dangerousConditionCategories"]
        .map((x) => ConditionCategory.fromMap(x))),
    violatedEmployees: json["violatedEmployees"] == null
        ? null
        : List<Person>.from(
        json["violatedEmployees"].map((x) => Person.fromMap(x))),
    initiatorPrivacy:
    json["initiatorPrivacy"] == null ? null : json["initiatorPrivacy"],
    requestNumber:
    json["requestNumber"] == null ? null : json["requestNumber"],
    initDateTime: json["initDateTime"] == null
        ? null
        : DateTime.parse(json["initDateTime"]),
    sevirity: json["sevirity"] == null
        ? null
        : AbstractDictionary.fromMap(json["sevirity"]),
    otherViolationComment: json["otherViolationComment"] == null
        ? null
        : json["otherViolationComment"],
    organization: json["organization"] == null
        ? null
        : Organization.fromMap(json["organization"]),
    objectName: json["objectName"] == null
        ? null
        : ObjectName.fromMap(json["objectName"]),
    files: json["files"] == null
        ? null
        : List<FileDescriptor>.from(
        json["files"].map((x) => FileDescriptor.fromMap(x))),
    comment: json["comment"] == null ? null : json["comment"],
    takenAction: json["takenAction"] == null
        ? null
        : AbstractDictionary.fromMap(json["takenAction"]),
    category: json["category"] == null
        ? null
        : AbstractDictionary.fromMap(json["category"]),
    department: json["department"] == null
        ? null
        : Department.fromMap(json["department"]),
    dangerousActions: json["dangerousActions"] == null
        ? null
        : List<AbstractDictionary>.from(
        json["dangerousActions"].map((x) => AbstractDictionary.fromMap(x))),
    status:
    json["status"] == null ? null : AbstractDictionary.fromMap(json["status"]),
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "regDateTime":
    regDateTime == null ? null : regDateTime.toIso8601String(),
    "initiator": initiator == null ? null : initiator.toMap(),
    "dangerousConditionCategories": dangerousConditionCategories == null
        ? null
        : List<dynamic>.from(
        dangerousConditionCategories.map((x) => x.toMap())),
    "violatedEmployees": violatedEmployees == null
        ? null
        : List<dynamic>.from(violatedEmployees.map((x) => x.toMap())),
    "initiatorPrivacy": initiatorPrivacy == null ? null : initiatorPrivacy,
    "requestNumber": requestNumber == null ? null : requestNumber,
    "initDateTime":
    initDateTime == null ? null : initDateTime.toIso8601String(),
    "sevirity": sevirity == null ? null : sevirity.toMap(),
    "otherViolationComment":
    otherViolationComment == null ? null : otherViolationComment,
    "organization": organization == null ? null : organization.toMap(),
    "objectName": objectName == null ? null : objectName.toMap(),
    "files": files == null
        ? null
        : List<dynamic>.from(files.map((x) => x.toMap())),
    "comment": comment == null ? null : comment,
    "takenAction": takenAction == null ? null : takenAction.toMap(),
    "category": category == null ? null : category.toMap(),
    "department": department == null ? null : department.toMap(),
    "dangerousActions": dangerousActions == null
        ? null
        : List<dynamic>.from(dangerousActions.map((x) => x.toMap())),
    "status": status == null ? null : status.toMap(),
  };

  String toJsonCreate() {
    var map = toMapCreate();

    if(comment != null) {
      map.putIfAbsent('comment', () => comment);
    }

    if(otherViolationComment != null) {
      map.putIfAbsent('otherViolationComment', () => otherViolationComment);
    }

    if(dangerousActions != null && dangerousActions.isNotEmpty) {
      map.putIfAbsent('dangerousActions', () => List<dynamic>.from(dangerousActions.map((x) => x.toMap())));
    }
    if(dangerousConditionCategories != null && dangerousConditionCategories.isNotEmpty) {
      map.putIfAbsent('dangerousConditionCategories', () => List<dynamic>.from(
          dangerousConditionCategories.map((x) => x.toMap())));
    }

    if(violatedEmployees != null && violatedEmployees.isNotEmpty) {
      map.putIfAbsent('violatedEmployees', () => List<dynamic>.from(violatedEmployees.map((x) => x.toMapId())));
    }
    return json.encode(map);
  }

  Map<String, dynamic> toMapCreate() => {
    'id': id ?? '',
    'initiatorPrivacy': initiatorPrivacy,
    'initDateTime': formatFullRest(initDateTime),
    'organization': organization.toMap(),
    'objectName': objectName.toMap(),
    'files': files == null
        ? null
        : List<dynamic>.from(files.map((x) => x.toMap())),
    'takenAction': takenAction.toMap(),
    'category': category.toMap(),
    'department': department.toMap(),
  };
}
