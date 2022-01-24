import 'dart:convert';

import 'package:hive/hive.dart';

import 'Person.dart';
import 'WorkLaborSpending.dart';

part 'TransportOrderPojoWork.g.dart';

@HiveType(typeId: 39)
class TransportOrderPojoWork {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String uom;
  @HiveField(3)
  List<WorkLaborSpending> laborSpending;
  @HiveField(4)
  String route;
  @HiveField(5)
  double trip;
  @HiveField(6)
  bool hazard;
  @HiveField(7)
  Person person;
  @HiveField(8)
  String workType;
  @HiveField(9)
  String equipment;
  @HiveField(10)
  double weight;
  @HiveField(11)
  String operationType;
  @HiveField(12)
  String workPlace;

  TransportOrderPojoWork({
    this.entityName,
    this.id,
    this.uom,
    this.laborSpending,
    this.route,
    this.trip,
    this.hazard,
    this.person,
    this.workType,
    this.equipment,
    this.weight,
    this.operationType,
    this.workPlace,
  });

  factory TransportOrderPojoWork.fromJson(String str) =>
      TransportOrderPojoWork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TransportOrderPojoWork.fromMap(Map<String, dynamic> json) =>
      TransportOrderPojoWork(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        uom: json["uom"] == null ? null : json["uom"],
        laborSpending: json["laborSpending"] == null
            ? []
            : List<WorkLaborSpending>.from(
                json["laborSpending"].map((x) => WorkLaborSpending.fromMap(x))),
        route: json["route"] == null ? null : json["route"],
        trip: json["trip"] == null ? null : json["trip"],
        hazard: json["hazard"] == null ? null : json["hazard"],
        person: json["person"] == null ? null : Person.fromMap(json["person"]),
        workType: json["workType"] == null ? null : json["workType"],
        equipment: json["equipment"] == null ? null : json["equipment"],
        weight: json["weight"] == null ? null : json["weight"],
        operationType:
            json["operationType"] == null ? null : json["operationType"],
        workPlace: json["workPlace"] == null ? null : json["workPlace"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "uom": uom == null ? null : uom,
        "laborSpending": laborSpending == null
            ? []
            : List<dynamic>.from(laborSpending.map((x) => x.toMap())),
        "route": route == null ? null : route,
        "trip": trip == null ? null : trip,
        "hazard": hazard == null ? null : hazard,
        "person": person == null ? null : person.toMap(),
        "workType": workType == null ? null : workType,
        "equipment": equipment == null ? null : equipment,
        "weight": weight == null ? null : weight,
        "operationType": operationType == null ? null : operationType,
        "workPlace": workPlace == null ? null : workPlace,
      };
}
