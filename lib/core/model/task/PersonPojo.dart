import 'dart:convert';

import 'package:hive/hive.dart';

part 'PersonPojo.g.dart';

@HiveType(typeId: 30)
class PersonPojo {
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
  String middleName;

  PersonPojo({
    this.entityName,
    this.id,
    this.firstName,
    this.lastName,
    this.image,
    this.middleName,
  });

  factory PersonPojo.fromJson(String str) =>
      PersonPojo.fromMap(json.decode(str));

  factory PersonPojo.fromMap(Map<String, dynamic> json) => PersonPojo(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        firstName: json["firstName"] == null ? "" : json["firstName"],
        lastName: json["lastName"] == null ? "" : json["lastName"],
        image: json["image"] == null ? null : json["image"],
        middleName: json["middleName"] == null ? "" : json["middleName"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "image": image == null ? null : image,
        "middleName": middleName == null ? null : middleName,
      };
}
