import 'dart:convert';

import 'package:hive/hive.dart';

part 'Vehicle.g.dart';

@HiveType(typeId: 14)
class Vehicle {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String marc;
  @HiveField(3)
  String stateNumber;
  @HiveField(4)
  String model;

  Vehicle({
    this.entityName,
    this.id,
    this.marc,
    this.stateNumber,
    this.model,
  });

  factory Vehicle.fromJson(String str) => Vehicle.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vehicle.fromMap(Map<String, dynamic> json) => Vehicle(
        entityName: json["_entityName"] == null ? '' : json["_entityName"],
        id: json["id"] == null ? '' : json["id"],
        marc: json["marc"] == null ? '' : json["marc"],
        stateNumber: json["stateNumber"] == null ? '' : json["stateNumber"],
        model: json["model"] == null ? '' : json["model"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "marc": marc == null ? null : marc,
        "stateNumber": stateNumber == null ? null : stateNumber,
        "model": model == null ? null : model,
      };
}
