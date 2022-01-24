import 'dart:convert';

import 'package:hive/hive.dart';

part 'Ppe.g.dart';

@HiveType(typeId: 7)
class Ppe {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String image;
  @HiveField(4)
  bool overNorm;
  @HiveField(5)
  String langValue;
  @HiveField(6)
  String description;
  @HiveField(7)
  double perscentWear;
  @HiveField(8)
  String size;
  @HiveField(9)
  DateTime endDate;
  @HiveField(10)
  String seasonSign;
  @HiveField(11)
  DateTime issueDate;
  @HiveField(12)
  String sizeGrowth;
  @HiveField(13)
  DateTime watchDate;
  @HiveField(14)
  double actualCost;

  Ppe(
      {this.entityName,
      this.instanceName,
      this.id,
      this.image,
      this.overNorm,
      this.langValue,
      this.description,
      this.perscentWear,
      this.size,
      this.endDate,
      this.seasonSign,
      this.issueDate,
      this.sizeGrowth,
      this.watchDate,
      this.actualCost});

  factory Ppe.fromJson(String str) => Ppe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ppe.fromMap(Map<String, dynamic> json) => Ppe(
      entityName: json["_entityName"] == null ? null : json["_entityName"],
      instanceName:
          json["_instanceName"] == null ? null : json["_instanceName"],
      id: json["id"] == null ? null : json["id"],
      image: json["image"] == null ? null : json["image"],
      overNorm: json["overNorm"] == null ? null : json["overNorm"],
      langValue: json["langValue"] == null ? '' : json["langValue"],
      description: json["description"] == null ? null : json["description"],
      perscentWear: json["perscentWear"] == null
          ? null
          : json["perscentWear"] <= 0
              ? 1.0
              : json["perscentWear"].toDouble(),
      size: json["size"] == null ? '' : json["size"],
      endDate: json["endDate"] == null ? null : DateTime.parse(json["endDate"]),
      seasonSign: json["seasonSign"] == null ? '' : json["seasonSign"],
      issueDate:
          json["issueDate"] == null ? null : DateTime.parse(json["issueDate"]),
      sizeGrowth: json["sizeGrowth"] == null ? '' : json["sizeGrowth"],
      watchDate:
          json["watchDate"] == null ? null : DateTime.parse(json["watchDate"]),
      actualCost:
          json["actualCost"] == null ? null : json["actualCost"].toDouble());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "image": image == null ? null : image,
        "overNorm": overNorm == null ? null : overNorm,
        "langValue": langValue == null ? null : langValue,
        "description": description == null ? null : description,
        "perscentWear": perscentWear == null ? null : perscentWear,
        "size": size == null ? null : size,
        "endDate": endDate == null ? null : endDate.toIso8601String(),
        "seasonSign": seasonSign == null ? null : seasonSign,
        "issueDate": issueDate == null ? null : issueDate.toIso8601String(),
        "sizeGrowth": sizeGrowth == null ? null : sizeGrowth,
        "watchDate": watchDate == null ? '' : watchDate.toIso8601String(),
        "actualCost": actualCost == null ? null : actualCost
      };
}
