import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/assignment/rating_new.dart';

import 'Department.dart';
import 'FoodLimits.dart';
import 'Job.dart';
import 'Organization.dart';
import 'Person.dart';
import 'Rating.dart';

part 'Assignment.g.dart';

@HiveType(typeId: 3)
class Assignment {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String orderNumber;
  @HiveField(3)
  String address;
  @HiveField(4)
  Person person;
  @HiveField(5)
  String groupId;
  @HiveField(6)
  Rating rating;
  @HiveField(7)
  Organization organization;
  @HiveField(8)
  Job job;
  @HiveField(9)
  Department department;
  @HiveField(10)
  FoodLimits limits;
  @HiveField(11)
  PercentilePojo percentilePojo;

  Assignment({
    this.entityName,
    this.id,
    this.orderNumber,
    this.address,
    this.person,
    this.groupId,
    this.organization,
    this.job,
    this.rating,
    this.department,
    this.limits,
    this.percentilePojo,
  });

  factory Assignment.fromJson(String str) =>
      Assignment.fromMap(json.decode(str));

  factory Assignment.fromMap(Map<String, dynamic> json) => Assignment(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        orderNumber: json["orderNumber"] == null ? null : json["orderNumber"],
        address: json["address"] == null ? "" : json["address"],
        person: json["person"] == null ? null : Person.fromMap(json["person"]),
        groupId: json["groupId"] == null ? null : json["groupId"],
        limits:
            json["limits"] == null ? null : FoodLimits.fromMap(json["limits"]),
        organization: json["organization"] == null
            ? null
            : Organization.fromMap(json["organization"]),
        job: json["job"] == null ? null : Job.fromMap(json["job"]),
        rating: json["rating"] == null ? null : Rating.fromMap(json["rating"]),
        department: json["department"] == null
            ? null
            : Department.fromMap(json["department"]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName,
        'id': id,
        "orderNumber": orderNumber,
        "address": address ?? "",
        "person": person == null ? null : person.toMap(),
        "groupId": groupId,
        "limits": limits,
        "organization": organization == null ? null : organization.toMap(),
        "job": job == null ? null : job.toMap(),
        "rating": rating == null ? null : rating.toMap(),
        "department": department == null ? null : department.toMap(),
      };
}
