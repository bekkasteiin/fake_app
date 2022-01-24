import 'dart:convert';

import 'package:hive/hive.dart';

part 'Transport.g.dart';

@HiveType(typeId: 46)
class Transport {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  double trip;
  @HiveField(3)
  double plan;

  Transport({
    this.entityName,
    this.id,
    this.trip,
    this.plan,
  });

  factory Transport.fromJson(String str) => Transport.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Transport.fromMap(Map<String, dynamic> json) => Transport(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        trip: json["trip"] == null ? null : json["trip"],
        plan: json["plan"] == null ? null : json["plan"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "trip": trip == null ? null : trip,
        "plan": plan == null ? null : plan,
      };
}
