import 'dart:convert';

import 'package:hive/hive.dart';

import 'RepairOrderPojo.dart';
import 'TransportOrderPojo.dart';
import 'WorkOrderPojo.dart';
import 'WorkOrderShift.dart';

part 'AllOrderPojo.g.dart';

@HiveType(typeId: 31)
class AllOrderPojo {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  WorkOrderPojo workOrderPojo;
  @HiveField(3)
  bool responsible;
  @HiveField(4)
  String type;
  @HiveField(5)
  RepairOrderPojo repairOrderPojo;
  @HiveField(6)
  TransportOrderPojo transportOrderPojo;
  @HiveField(7)
  WorkOrderShift workOrderShift;

  AllOrderPojo({
    this.entityName,
    this.id,
    this.workOrderPojo,
    this.responsible,
    this.type,
    this.repairOrderPojo,
    this.transportOrderPojo,
    this.workOrderShift,
  });

  fromJson(String str) => AllOrderPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AllOrderPojo.fromMap(Map<String, dynamic> json) {
    var workJson = json['workOrderPojo'];
    var repairJson = json['repairOrderPojo'];
    var transportJson = json['transportOrderPojo'];
    var shiftJson = json['workOrderShift'];
    return AllOrderPojo(
      entityName: json['_entityName'],
      id: json['id'],
      workOrderPojo: workJson == null ? null : WorkOrderPojo.fromMap(workJson),
      responsible: json['responsible'],
      type: json['type'],
      repairOrderPojo:
          repairJson == null ? null : RepairOrderPojo.fromMap(repairJson),
      transportOrderPojo: transportJson == null
          ? null
          : TransportOrderPojo.fromMap(transportJson),
      workOrderShift:
          shiftJson == null ? null : WorkOrderShift.fromMap(shiftJson),
    );
  }

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        'id': id,
        'workOrderPojo': workOrderPojo?.toMap(),
        'responsible': responsible,
        'type': type,
        'repairOrderPojo': repairOrderPojo?.toMap(),
        'transportOrderPojo': transportOrderPojo?.toMap(),
        'workOrderShift': workOrderShift?.toMap(),
      };
}
