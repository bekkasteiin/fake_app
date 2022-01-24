import 'dart:convert';

import 'package:hive/hive.dart';

import 'ListOfEquipmentUsed.dart';
import 'Person.dart';
import 'WorkOrderPojoLaborSpending.dart';

part 'WorkOrderPojo.g.dart';

@HiveType(typeId: 41)
class WorkOrderPojo {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double totalFact;
  @HiveField(3)
  String production;
  @HiveField(4)
  double plannedVolume;
  @HiveField(5)
  String shift;
  @HiveField(6)
  List<Person> personPojo;
  @HiveField(7)
  DateTime plannedEndDate;
  @HiveField(8)
  List<ListOfEquipmentUsed> listOfEquipmentUsed;
  @HiveField(9)
  String number;
  @HiveField(10)
  String uom;
  @HiveField(11)
  List<WorkOrderPojoLaborSpending> laborSpending;
  @HiveField(12)
  String workType;
  @HiveField(13)
  String comment;
  @HiveField(14)
  String workOrderId;
  @HiveField(15)
  double totalPercent;
  @HiveField(16)
  String workplace;

  WorkOrderPojo({
    this.entityName,
    this.id,
    this.totalFact,
    this.production,
    this.plannedVolume,
    this.shift,
    this.personPojo,
    this.plannedEndDate,
    this.listOfEquipmentUsed,
    this.number,
    this.uom,
    this.laborSpending,
    this.workType,
    this.comment,
    this.workOrderId,
    this.totalPercent,
    this.workplace,
  });

  factory WorkOrderPojo.fromJson(String str) =>
      WorkOrderPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory WorkOrderPojo.fromMap(Map<String, dynamic> json) => WorkOrderPojo(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        totalFact: json["totalFact"] == null ? null : json["totalFact"],
        production: json["production"] == null ? null : json["production"],
        plannedVolume:
            json["plannedVolume"] == null ? null : json["plannedVolume"],
        shift: json["shift"] == null ? "" : json["shift"],
        personPojo: json["personPojo"] == null
            ? []
            : List<Person>.from(
                json["personPojo"].map((x) => Person.fromMap(x))),
        plannedEndDate: json["plannedEndDate"] == null
            ? null
            : DateTime.parse(json["plannedEndDate"]),
        listOfEquipmentUsed: json["listOfEquipmentUsed"] == null
            ? []
            : List<ListOfEquipmentUsed>.from(json["listOfEquipmentUsed"]
                .map((x) => ListOfEquipmentUsed.fromMap(x))),
        number: json["number"] == null ? null : json["number"],
        uom: json["uom"] == null ? null : json["uom"],
        laborSpending: json["laborSpending"] == null
            ? []
            : List<WorkOrderPojoLaborSpending>.from(json["laborSpending"]
                .map((x) => WorkOrderPojoLaborSpending.fromMap(x))),
        workType: json["workType"] == null ? null : json["workType"],
        comment: json["comment"] == null ? null : json["comment"],
        workOrderId: json["workOrderId"] == null ? null : json["workOrderId"],
        totalPercent:
            json["totalPercent"] == null ? null : json["totalPercent"],
        workplace: json["workplace"] == null ? null : json["workplace"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "totalFact": totalFact == null ? null : totalFact,
        "production": production == null ? null : production,
        "plannedVolume": plannedVolume == null ? null : plannedVolume,
        "shift": shift == null ? null : shift,
        "personPojo": personPojo == null
            ? []
            : List<dynamic>.from(personPojo.map((x) => x.toMap())),
        "plannedEndDate":
            plannedEndDate == null ? null : plannedEndDate.toIso8601String(),
        "listOfEquipmentUsed": listOfEquipmentUsed == null
            ? []
            : List<dynamic>.from(listOfEquipmentUsed.map((x) => x.toMap())),
        "number": number == null ? null : number,
        "uom": uom == null ? null : uom,
        "laborSpending": laborSpending == null
            ? []
            : List<dynamic>.from(laborSpending.map((x) => x.toMap())),
        "workType": workType == null ? null : workType,
        "comment": comment == null ? null : comment,
        "workOrderId": workOrderId == null ? null : workOrderId,
        "totalPercent": totalPercent == null ? null : totalPercent,
        "workplace": workplace == null ? null : workplace,
      };
}
