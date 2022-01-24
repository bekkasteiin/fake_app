import 'dart:convert';

import 'package:hive/hive.dart';

part 'rating_new.g.dart';

@HiveType(typeId: 81)
class PercentilePojo {
  PercentilePojo({
    this.lowLimit = 0.0,
    this.highLimit = 0.0,
    this.lowestScore = 0.0,
    this.highestScore = 0.0,
    this.totalNumberOfScores = 0.0,
    this.currentEmpRank = 0.0,
    this.currentEmpRating = 0.0,
  });

  @HiveField(0)
  num lowLimit;
  @HiveField(1)
  num highLimit;
  @HiveField(2)
  num lowestScore;
  @HiveField(3)
  num highestScore;
  @HiveField(4)
  num totalNumberOfScores;
  @HiveField(5)
  num currentEmpRank;
  @HiveField(6)
  num currentEmpRating;

  factory PercentilePojo.fromJson(String str) =>
      PercentilePojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PercentilePojo.fromMap(Map<String, dynamic> json) => PercentilePojo(
        lowLimit: json["lowLimit"],
        highLimit: json["highLimit"],
        lowestScore: json["lowestScore"],
        highestScore: json["highestScore"],
        totalNumberOfScores: json["totalNumberOfScores"],
        currentEmpRank: json["currentEmpRank"],
        currentEmpRating: json["currentEmpRating"],
      );

  Map<String, dynamic> toMap() => {
        "lowLimit": lowLimit,
        "highLimit": highLimit,
        "lowestScore": lowestScore,
        "highestScore": highestScore,
        "totalNumberOfScores": totalNumberOfScores,
        "currentEmpRank": currentEmpRank,
      };
}
