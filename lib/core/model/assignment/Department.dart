import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Person.dart';
import 'package:hse/core/model/message/object_name.dart';

part 'Department.g.dart';

@HiveType(typeId: 8)
class Department {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String departmentName;
  @HiveField(3)
  String groupId;
  @HiveField(4)
  List<ObjectName> objectName;
  @HiveField(5)
  List<Person> employees;

  Department(
      {this.entityName,
      this.id,
      this.departmentName,
      this.groupId,
      this.employees,
      this.objectName});

  factory Department.fromJson(String str) =>
      Department.fromMap(json.decode(str));

  factory Department.fromMap(Map<String, dynamic> json) => Department(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        departmentName:
            json["departmentName"] == null ? null : json["departmentName"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        objectName: json["objectName"] == null
            ? null
            : List<ObjectName>.from(
                json["objectName"].map((x) => ObjectName.fromMap(x))),
        employees: json["employees"] == null
            ? null
            : List<Person>.from(
                json["employees"].map((x) => Person.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "departmentName": departmentName == null ? null : departmentName,
        "groupId": groupId == null ? null : groupId,
      };
}
