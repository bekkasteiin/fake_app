import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/file_descriptor.dart';
import 'package:hse/core/model/util_models.dart';

part 'Person.g.dart';

@HiveType(typeId: 11)
class Person {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  DateTime birthday;
  @HiveField(3)
  String firstName;
  @HiveField(4)
  String lastName;
  @HiveField(5)
  String image;
  @HiveField(6)
  String sex;
  @HiveField(7)
  String groupId;
  @HiveField(8)
  String middleName;
  @HiveField(9)
  String nationalIdentifier;
  @HiveField(10)
  String employeeNumber;
  @HiveField(11)
  String phone;
  @HiveField(12)
  String email;
  @HiveField(13)
  FileDescriptor photo;
  @HiveField(14)
  String fullName;

  Person(
      {this.entityName,
      this.id,
      this.birthday,
      this.firstName,
      this.lastName,
      this.image,
      this.sex,
      this.phone,
      this.email,
      this.groupId,
      this.middleName,
      this.nationalIdentifier,
      this.employeeNumber,
      this.fullName,
      this.photo});

  factory Person.fromJson(String str) => Person.fromMap(json.decode(str));

  factory Person.fromMap(Map<String, dynamic> json) => Person(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        image: json["image"] == null ? null : json["image"],
        sex: json["sex"] == null ? null : json["sex"],
        phone: json["phone"] == null ? null : json["phone"],
        email: json["email"] == null ? null : json["email"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        middleName: json["middleName"] == null ? null : json["middleName"],
        nationalIdentifier: json["nationalIdentifier"] == null
            ? null
            : json["nationalIdentifier"],
        employeeNumber:
            json["employeeNumber"] == null ? null : json["employeeNumber"],
        photo: json["photo"] == null
            ? null
            : FileDescriptor.fromMap(json["photo"]),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "fullName": fullName == null ? null : fullName,
        "id": id == null ? null : id,
        "birthday": birthday == null ? null : dateTimeToString(birthday),
        "firstName": firstName == null ? "" : firstName,
        "lastName": lastName == null ? "" : lastName,
        "image": image == null ? null : image,
        "sex": sex == null ? null : sex,
        "phone": phone == null ? null : phone,
        "email": email == null ? null : email,
        "groupId": groupId == null ? null : groupId,
        "middleName": middleName == null ? "" : middleName,
        "nationalIdentifier":
            nationalIdentifier == null ? null : nationalIdentifier,
        "employeeNumber": employeeNumber == null ? null : employeeNumber,
      };

  Map<String, dynamic> toMapId() => {'id': id ?? ''};
}
