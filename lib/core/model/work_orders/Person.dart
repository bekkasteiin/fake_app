import 'dart:convert';

import 'package:hive/hive.dart';

part 'Person.g.dart';

@HiveType(typeId: 37)
class Person {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String firstName;
  @HiveField(3)
  String lastName;
  @HiveField(4)
  String image;
  @HiveField(5)
  String groupId;
  @HiveField(6)
  String stateNumber;
  @HiveField(7)
  String middleName;
  @HiveField(8)
  String equipmentName;

  Person({
    this.entityName,
    this.id,
    this.lastName,
    this.groupId,
    this.firstName,
    this.stateNumber,
    this.image,
    this.middleName,
    this.equipmentName,
  });

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        image: json["image"] == null ? null : json["image"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        stateNumber: json["stateNumber"] == null ? null : json["stateNumber"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        equipmentName:
            json["equipmentName"] == null ? null : json["equipmentName"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "lastName": lastName == null ? null : lastName,
        "groupId": groupId == null ? null : groupId,
        "firstName": firstName == null ? null : firstName,
        "image": image == null ? null : image,
        "stateNumber": stateNumber == null ? null : stateNumber,
        "middleName": middleName == null ? null : middleName,
        "equipmentName": equipmentName == null ? null : equipmentName,
      };
}
