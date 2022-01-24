import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'Answer.dart';

part 'Test.g.dart';

Test testFromJson(String str) => Test.fromMap(json.decode(str));

String testToJson(Test data) => json.encode(data.toMap());

@HiveType(typeId: 59)
class Test {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  double result;
  @HiveField(4)
  int duration;
  @HiveField(5)
  List<Answer> answers;
  @HiveField(6)
  DateTime testDate;
  @HiveField(7)
  DateTime startTime;
  @HiveField(8)
  DateTime endTime;
  @HiveField(9)
  int timeForQuestion;

  Test({
    this.entityName,
    this.instanceName,
    this.id,
    this.result,
    this.duration,
    this.answers,
    this.testDate,
    this.startTime,
    this.endTime,
    this.timeForQuestion,
  });

  String toJson() => json.encode(toMap());

  fromJson(String str) => Test.fromMap(json.decode(str));

  factory Test.fromMap(Map<String, dynamic> json) => Test(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        instanceName:
            json["_instanceName"] == null ? null : json["_instanceName"],
        id: json["id"] == null ? null : json["id"],
        result: json["result"] == null ? null : double.parse(json["result"]),
        duration: json["duration"] == null ? null : json["duration"],
        timeForQuestion:
            json["timeForQuestion"] == null ? null : json["timeForQuestion"],
        answers: json["answers"] == null
            ? []
            : List<Answer>.from(json["answers"].map((x) => Answer.fromMap(x))),
        testDate:
            json["testDate"] == null ? null : DateTime.parse(json["testDate"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "duration": duration == null ? null : duration,
        "timeForQuestion": timeForQuestion == null ? null : timeForQuestion,
        "result": result == null ? null : result.toString(),
        "answers": answers == null
            ? []
            : List<dynamic>.from(answers.map((x) => x.toMap())),
        "testDate": testDate == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(testDate),
        "startTime": startTime == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(startTime),
        "endTime": endTime == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(endTime),
      };

  Map<String, dynamic> toBaseMap() => {
        "_entityName": entityName == null ? null : entityName,
        "_instanceName": instanceName == null ? null : instanceName,
        "id": id == null ? null : id,
        "duration": duration == null ? null : duration,
        "result": result == null ? null : result,
        "testDate": testDate == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(testDate),
        "startTime": startTime == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(startTime),
        "endTime": endTime == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(endTime),
      };
}
