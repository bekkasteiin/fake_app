import 'dart:convert';

import 'package:hive/hive.dart';

part 'Driver.g.dart';

@HiveType(typeId: 13)
class Driver {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String contact;
  @HiveField(3)
  String fullName;

  Driver({
    this.entityName,
    this.id,
    this.contact,
    this.fullName,
  });

  factory Driver.fromJson(String str) => Driver.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Driver.fromMap(Map<String, dynamic> json) {
    return Driver(
      entityName: json["_entityName"] == null ? '' : json["_entityName"],
      id: json["id"] == null ? '' : json["id"],
      contact: json["contact"] == null ? '' : json["contact"],
      fullName: json["fullName"] == null ? '' : json["fullName"],
    );
  }

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "contact": contact == null ? null : contact,
        "fullName": fullName == null ? null : fullName,
      };
}
