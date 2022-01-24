import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/course_eating/Dish.dart';

part 'CourseEatingHistory.g.dart';

@HiveType(typeId: 16)
class CourseEatingHistory {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  double assessment;
  @HiveField(4)
  DateTime courseEatingDate;
  @HiveField(5)
  String location;
  @HiveField(6)
  double amount;
  @HiveField(7)
  List<Dish> dishes;
  @HiveField(8)
  String locationGroup;
  @HiveField(9)
  double dayLimitOverrun;

  CourseEatingHistory({
    this.entityName,
    this.instanceName,
    this.id,
    this.assessment,
    this.courseEatingDate,
    this.location,
    this.dishes,
    this.amount,
    this.locationGroup,
    this.dayLimitOverrun,
  });

  factory CourseEatingHistory.fromJson(String str) =>
      CourseEatingHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CourseEatingHistory.fromMap(Map<String, dynamic> json) =>
      CourseEatingHistory(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        assessment: json["assessment"] == null ? null : json["assessment"],
        courseEatingDate: json["courseEatingDate"] == null
            ? null
            : DateTime.parse(json["courseEatingDate"]),
        location: json["location"] == null ? null : json["location"],
        dishes: json["dishes"] == null
            ? []
            : List<Dish>.from(json["dishes"].map((x) => Dish.fromMap(x))),
        amount: json["amount"] == null || json["amount"] == 0
            ? 0.0
            : json["amount"],
        dayLimitOverrun:
            json["dayLimitOverrun"] == null || json["dayLimitOverrun"] == 0
                ? 0.0
                : json["dayLimitOverrun"],
        locationGroup:
            json["locationGroup"] == null ? null : json["locationGroup"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "assessment": assessment == null ? null : assessment,
        "courseEatingDate": courseEatingDate == null
            ? null
            : courseEatingDate.toIso8601String(),
        "location": location == null ? null : location,
        "amount": amount,
        "dayLimitOverrun": dayLimitOverrun,
        "dishes": dishes == null
            ? []
            : List<dynamic>.from(dishes.map((x) => x.toMap())),
        "locationGroup": locationGroup == null ? null : locationGroup,
      };
}
