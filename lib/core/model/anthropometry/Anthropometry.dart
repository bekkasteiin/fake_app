// To parse this JSON data, do
//
//     final anthropometry = anthropometryFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';

part 'Anthropometry.g.dart';

@HiveType(typeId: 1)
class Anthropometry {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String clothingSize;
  @HiveField(3)
  String shoeSize;
  @HiveField(4)
  String handSize;
  @HiveField(5)
  String personGroupId;
  @HiveField(6)
  double weight;
  @HiveField(7)
  String headSize;
  @HiveField(8)
  double height;

  Anthropometry({
    this.entityName,
    this.id,
    this.clothingSize,
    this.shoeSize,
    this.handSize,
    this.personGroupId,
    this.weight,
    this.headSize,
    this.height,
  });

  factory Anthropometry.fromJson(String str) =>
      Anthropometry.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Anthropometry.fromMap(Map<String, dynamic> json) => Anthropometry(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        clothingSize:
            json["clothingSize"] == null ? null : json["clothingSize"],
        shoeSize: json["shoeSize"] == null ? null : json["shoeSize"],
        handSize: json["handSize"] == null ? null : json["handSize"],
        personGroupId:
            json["personGroupId"] == null ? null : json["personGroupId"],
        weight: json["weight"] == null ? null : json["weight"],
        headSize: json["headSize"] == null ? null : json["headSize"],
        height: json["height"] == null ? null : json["height"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "clothingSize": clothingSize == null ? null : clothingSize,
        "shoeSize": shoeSize == null ? null : shoeSize,
        "handSize": handSize == null ? null : handSize,
        "personGroupId": personGroupId == null ? null : personGroupId,
        "weight": weight == null ? null : weight,
        "headSize": headSize == null ? null : headSize,
        "height": height == null ? null : height,
      };
}
