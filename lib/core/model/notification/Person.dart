import 'dart:convert';

import 'package:hive/hive.dart';

part 'Person.g.dart';

@HiveType(typeId: 50)
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
  String organization;
  @HiveField(6)
  String middleName;
  @HiveField(7)
  String department;

  Person({
    this.entityName,
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.organization,
    this.middleName,
    this.department,
  });

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? "" : json["firstName"],
        lastName: json["lastName"] == null ? "" : json["lastName"],
        image: json["image"] == null ? null : json["image"],
        organization:
            json["organization"] == null ? null : json["organization"],
        middleName: json["middleName"] == null ? "" : json["middleName"],
        department: json["department"] == null ? null : json["department"],
      );

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "firstName": firstName == null ? "" : firstName,
        "lastName": lastName == null ? "" : lastName,
        "image": image == null ? null : image,
        "organization": organization == null ? "" : organization,
        "middleName": middleName == null ? "" : middleName,
        "department": department == null ? "" : department,
      };
}
