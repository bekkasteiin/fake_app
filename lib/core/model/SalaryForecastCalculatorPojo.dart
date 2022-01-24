import 'dart:convert';

import 'BaseResult.dart';

class SalaryForecastCalculatorPojo {
  String personGroupId;
  double tDays;
  double cDay;
  double pDay;
  double tPersents;
  double cPersent;
  double pPersent;
  double cSalary;
  double pSalary;
  BaseResult baseResult;

  SalaryForecastCalculatorPojo({
    this.personGroupId,
    this.tDays,
    this.cDay,
    this.pDay,
    this.tPersents,
    this.cPersent,
    this.pPersent,
    this.cSalary,
    this.pSalary,
    this.baseResult,
  });

  factory SalaryForecastCalculatorPojo.fromJson(String str) =>
      SalaryForecastCalculatorPojo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SalaryForecastCalculatorPojo.fromMap(Map<String, dynamic> json) =>
      SalaryForecastCalculatorPojo(
        personGroupId:
            json["personGroupId"] == null ? null : json["personGroupId"],
        tDays: json["tDays"] == null ? null : json["tDays"].toDouble(),
        cDay: json["cDay"] == null ? null : json["cDay"].toDouble(),
        pDay: json["pDay"] == null ? null : json["pDay"].toDouble(),
        tPersents:
            json["tPercents"] == null ? null : json["tPercents"].toDouble(),
        cPersent: json["cPercent"] == null ? null : json["cPercent"].toDouble(),
        pPersent: json["pPercent"] == null ? null : json["pPercent"].toDouble(),
        cSalary: json["cSalary"] == null ? null : json["cSalary"].toDouble(),
        pSalary: json["pSalary"] == null ? null : json["pSalary"].toDouble(),
        baseResult: json["baseResult"] == null
            ? null
            : BaseResult.fromMap(json["baseResult"]),
      );

  Map<String, dynamic> toMap() => {
        "personGroupId": personGroupId == null ? null : personGroupId,
        "tDays": tDays == null ? null : tDays,
        "cDay": cDay == null ? null : cDay,
        "pDay": pDay == null ? null : pDay,
        "tPercents": tPersents == null ? null : tPersents,
        "cPercent": cPersent == null ? null : cPersent,
        "pPercent": pPersent == null ? null : pPersent,
        "cSalary": cSalary == null ? null : cSalary,
        "pSalary": pSalary == null ? null : pSalary,
        "baseResult": baseResult == null ? null : baseResult.toMap(),
      };
}
