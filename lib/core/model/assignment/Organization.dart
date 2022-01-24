import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/Department.dart';

part 'Organization.g.dart';

@HiveType(typeId: 10)
class Organization {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String organizationName;
  @HiveField(3)
  String groupId;
  @HiveField(4)
  String orgAddress;
  @HiveField(5)
  List<Department> departments;

  Organization(
      {this.entityName,
      this.id,
      this.organizationName,
      this.groupId,
      this.orgAddress,
      this.departments});

  factory Organization.fromJson(String str) =>
      Organization.fromMap(json.decode(str));

  factory Organization.fromMap(Map<String, dynamic> json) => Organization(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        organizationName:
            json["organizationName"] == null ? null : json["organizationName"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        orgAddress: json["orgAddress"] == null ? "" : json["orgAddress"],
        departments: json["departments"] == null
            ? null
            : List<Department>.from(
                json["departments"].map((x) => Department.fromMap(x))),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "organizationName": organizationName == null ? null : organizationName,
        "groupId": groupId == null ? null : groupId,
        "orgAddress": orgAddress == null ? "" : orgAddress,
      };
}
