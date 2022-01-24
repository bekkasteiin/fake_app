import 'dart:convert';

import 'package:hive/hive.dart';

part 'Job.g.dart';

@HiveType(typeId: 9)
class Job {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String jobName;
  @HiveField(3)
  String code;
  @HiveField(4)
  String groupId;
  @HiveField(5)
  String aup;

  Job({
    this.entityName,
    this.id,
    this.jobName,
    this.code,
    this.groupId,
    this.aup,
  });

  factory Job.fromJson(String str) => Job.fromMap(json.decode(str));

  factory Job.fromMap(Map<String, dynamic> json) => Job(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        jobName: json["jobName"] == null ? null : json["jobName"],
        code: json["code"] == null ? null : json["code"],
        groupId: json["groupId"] == null ? null : json["groupId"],
        aup: json["aup"] == null ? null : json["aup"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "jobName": jobName == null ? null : jobName,
        "code": code == null ? null : code,
        "groupId": groupId == null ? null : groupId,
        "aup": aup == null ? null : aup,
      };
}
