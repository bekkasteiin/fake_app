import 'dart:convert';

import 'package:hive/hive.dart';

import 'Person.dart';
import 'Transport.dart';
import 'WorkLaborSpending.dart';

part 'WorkOrderShiftWork.g.dart';

@HiveType(typeId: 45)
class WorkOrderShiftWork {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String uom;
  @HiveField(3)
  List<WorkLaborSpending> laborSpending;
  @HiveField(4)
  String production;
  @HiveField(5)
  bool work;
  @HiveField(6)
  List<Person> person;
  @HiveField(7)
  String workType;
  @HiveField(8)
  String equipment;
  @HiveField(9)
  String comment;
  @HiveField(10)
  double plan;
  @HiveField(11)
  Transport transport;
  @HiveField(12)
  String operationType;
  @HiveField(13)
  String workPlace;

  WorkOrderShiftWork({
    this.entityName,
    this.id,
    this.uom,
    this.plan,
    this.laborSpending,
    this.production,
    this.work,
    this.person,
    this.workType,
    this.equipment,
    this.operationType,
    this.comment,
    this.transport,
    this.workPlace,
  });

  factory WorkOrderShiftWork.fromJson(String str) =>
      WorkOrderShiftWork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkOrderShiftWork.fromMap(Map<String, dynamic> json) =>
      WorkOrderShiftWork(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        uom: json["uom"] == null ? null : json["uom"],
        laborSpending: json["laborSpending"] == null
            ? []
            : List<WorkLaborSpending>.from(
                json["laborSpending"].map((x) => WorkLaborSpending.fromMap(x))),
        plan: json["plan"] == null ? null : json["plan"],
        production: json["production"] == null ? null : json["production"],
        work: json["work"] == null ? null : json["work"],
        person: json["person"] == null
            ? []
            : List<Person>.from(json["person"].map((x) => Person.fromMap(x))),
        workType: json["workType"] == null ? null : json["workType"],
        equipment: json["equipment"] == null ? null : json["equipment"],
        operationType:
            json["operationType"] == null ? null : json["operationType"],
        comment: json["comment"] == null ? '' : json["comment"],
        transport: json["transport"] == null
            ? null
            : Transport.fromMap(json["transport"]),
        workPlace: json["workPlace"] == null ? null : json["workPlace"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "uom": uom == null ? null : uom,
        "laborSpending": laborSpending == null
            ? []
            : List<dynamic>.from(laborSpending.map((x) => x.toMap())),
        "production": production == null ? null : production,
        "comment": comment == null ? null : comment,
        "plan": plan == null ? null : plan,
        "transport": transport == null ? null : transport.toMap(),
        "work": work == null ? null : work,
        "person": person == null
            ? []
            : List<dynamic>.from(person.map((x) => x.toMap())),
        "workType": workType == null ? null : workType,
        "equipment": equipment == null ? null : equipment,
        "operationType": operationType == null ? null : operationType,
        "workPlace": workPlace == null ? null : workPlace,
      };
}
