import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/notification/Person.dart';

import '../util_models.dart';
import 'Driver.dart';
import 'Vehicle.dart';

part 'Order.g.dart';

@HiveType(typeId: 12)
class Order {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String code;
  @HiveField(3)
  DateTime proposedDateAndTime;
  @HiveField(4)
  Driver driver;
  @HiveField(5)
  List<Person> person;
  @HiveField(6)
  Vehicle vehicle;

  Order({
    this.entityName,
    this.id,
    this.code,
    this.proposedDateAndTime,
    this.driver,
    this.person,
    this.vehicle,
  });

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  factory Order.fromMap(Map<String, dynamic> json) {
    return Order(
      entityName: json["_entityName"] == null ? null : json["_entityName"],
      id: json["id"] == null ? null : json["id"],
      code: json["code"] == null ? null : json["code"],
      proposedDateAndTime: json["proposedDateAndTime"] == null
          ? null
          : DateTime.parse(json["proposedDateAndTime"]),
      driver: json["driver"] == null
          ? null
          : (json["driver"] is String
              ? Driver.fromMap(jsonDecode(json["driver"]))
              : Driver.fromMap(json["driver"])),
      person: json["person"] == null
          ? []
          : List<Person>.from(json["person"].map((x) => (x is String
              ? Person.fromMap(jsonDecode(x))
              : Person.fromMap(x)))),
      vehicle: json["vehicle"] == null
          ? null
          : (json["vehicle"] is String
              ? Vehicle.fromMap(jsonDecode(json["vehicle"]))
              : Vehicle.fromMap(json["vehicle"])),
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "proposedDateAndTime": proposedDateAndTime == null
            ? null
            : dateTimeToString(proposedDateAndTime),
        "driver": driver == null ? null : driver.toMap(),
        "person": person == null
            ? []
            : List<dynamic>.from(person.map((x) => x.toMap())),
        "vehicle": vehicle == null ? null : vehicle.toMap(),
      };
}
