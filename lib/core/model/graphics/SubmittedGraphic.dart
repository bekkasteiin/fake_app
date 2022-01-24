import 'dart:convert';

import 'package:hive/hive.dart';

part 'SubmittedGraphic.g.dart';

@HiveType(typeId: 57)
class SubmittedGraphic {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  int passedTest;
  @HiveField(4)
  int allTests;
  @HiveField(5)
  double percent;

  SubmittedGraphic({
    this.entityName,
    this.instanceName,
    this.id,
    this.passedTest,
    this.allTests,
    this.percent,
  });

  fromJson(String str) => SubmittedGraphic.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SubmittedGraphic.fromMap(Map<String, dynamic> json) =>
      SubmittedGraphic(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        passedTest: json["passedTest"] == null ? null : json["passedTest"],
        allTests: json["allTests"] == null ? null : json["allTests"],
        percent: json["percent"] == null ? null : json["percent"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "passedTest": passedTest == null ? null : passedTest,
        "allTests": allTests == null ? null : allTests,
        "percent": percent == null ? null : percent,
      };
}
