import 'dart:convert';

import 'package:hive/hive.dart';

part 'DailyTasks.g.dart';

@HiveType(typeId: 18)
class DailyTasks {
  @HiveField(0)
  String id;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String equipment;
  @HiveField(3)
  String worksType;
  @HiveField(4)
  String worksPlan;
  @HiveField(5)
  String worksFact;

  DailyTasks({
    this.id,
    this.date,
    this.equipment,
    this.worksType,
    this.worksPlan,
    this.worksFact,
  });

  factory DailyTasks.fromJson(String str) =>
      DailyTasks.fromMap(json.decode(str));

  factory DailyTasks.fromMap(Map<String, dynamic> json) => DailyTasks(
        id: json["id"] == null ? null : json["id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        equipment: json["equipment"] == null ? null : json["equipment"],
        worksType: json["worksType"] == null ? null : json["worksType"],
        worksPlan: json["worksPlan"] == null ? null : json["worksPlan"],
        worksFact: json["worksFact"] == null ? null : json["worksFact"],
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "date": date == null ? null : date.toString(),
        "equipment": equipment == null ? null : equipment,
        "worksType": worksType == null ? null : worksType,
        "worksPlan": worksPlan == null ? null : worksPlan,
        "worksFact": worksFact == null ? null : worksFact,
      };
}
