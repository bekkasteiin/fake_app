import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'LaborSpending.dart';
import 'ListOfEquipmentUsed.dart';
import 'Medicine.dart';
import 'PersonPojo.dart';

part 'Task.g.dart';

@HiveType(typeId: 26)
class Task {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double totalFact;
  @HiveField(3)
  Medicine safetyExam;
  @HiveField(4)
  double plannedVolume;
  @HiveField(5)
  List<PersonPojo> personPojo;
  @HiveField(6)
  Medicine medicine;
  @HiveField(7)
  String type;
  @HiveField(8)
  DateTime plannedEndDate;
  @HiveField(9)
  List<ListOfEquipmentUsed> listOfEquipmentUsed;
  @HiveField(10)
  String number;
  @HiveField(11)
  String uom;
  @HiveField(12)
  List<LaborSpending> laborSpending;
  @HiveField(13)
  String workOrderId;
  @HiveField(14)
  double totalPercent;
  @HiveField(15)
  String workplace;
  @HiveField(16)
  String object;

  Task({
    this.entityName,
    this.id,
    this.totalFact,
    this.safetyExam,
    this.plannedVolume,
    this.personPojo,
    this.medicine,
    this.type,
    this.plannedEndDate,
    this.listOfEquipmentUsed,
    this.number,
    this.uom,
    this.laborSpending,
    this.workOrderId,
    this.totalPercent,
    this.workplace,
    this.object,
  });

  factory Task.fromJson(String str) => Task.fromMap(json.decode(str));

  factory Task.fromMap(Map<String, dynamic> json) => Task(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        totalFact: json["totalFact"] == null ? 0.0 : json["totalFact"],
        safetyExam: json["safetyExam"] == null
            ? ''
            : Medicine.fromMap(json["safetyExam"]),
        plannedVolume:
            json["plannedVolume"] == null ? '' : json["plannedVolume"],
        personPojo: json["personPojo"] == null
            ? []
            : List<PersonPojo>.from(
                json["personPojo"].map((x) => PersonPojo.fromMap(x))),
        medicine:
            json["medicine"] == null ? '' : Medicine.fromMap(json["medicine"]),
        type: json["type"] == null ? '' : json["type"],
        plannedEndDate: json["plannedEndDate"] == null
            ? ''
            : DateTime.parse(json["plannedEndDate"]),
        listOfEquipmentUsed: json["listOfEquipmentUsed"] == null
            ? []
            : List<ListOfEquipmentUsed>.from(json["listOfEquipmentUsed"]
                .map((x) => ListOfEquipmentUsed.fromMap(x))),
        number: json["number"] == null ? '' : json["number"],
        uom: json["uom"] == null ? '' : json["uom"],
        laborSpending: json["laborSpending"] == null
            ? []
            : List<LaborSpending>.from(
                json["laborSpending"].map((x) => LaborSpending.fromMap(x))),
        workOrderId: json["workOrderId"] == null ? '' : json["workOrderId"],
        totalPercent: json["totalPercent"] == null ? 0.0 : json["totalPercent"],
        workplace: json["workplace"] == null ? '' : json["workplace"],
        object: json["object"] == null ? '' : json["object"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "totalFact": totalFact == null ? null : totalFact,
        "safetyExam": safetyExam == null ? null : safetyExam.toMap(),
        "plannedVolume": plannedVolume == null ? null : plannedVolume,
        "personPojo": personPojo == null
            ? []
            : List<dynamic>.from(personPojo.map((x) => x.toMap())),
        "medicine": medicine == null ? null : medicine.toMap(),
        "type": type == null ? null : type,
        "plannedEndDate": plannedEndDate == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(plannedEndDate),
        "listOfEquipmentUsed": listOfEquipmentUsed == null
            ? []
            : List<dynamic>.from(listOfEquipmentUsed.map((x) => x.toMap())),
        "number": number == null ? null : number,
        "uom": uom == null ? null : uom,
        "laborSpending": laborSpending == null
            ? []
            : List<dynamic>.from(laborSpending.map((x) => x.toMap())),
        "workOrderId": workOrderId == null ? null : workOrderId,
        "totalPercent": totalPercent == null ? null : totalPercent,
        "workplace": workplace == null ? null : workplace,
        "object": object == null ? null : object,
      };
}
