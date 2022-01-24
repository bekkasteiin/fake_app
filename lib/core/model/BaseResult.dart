import 'dart:convert';

class BaseResult {
  bool success;
  String errorDescription;

  BaseResult({
    this.success,
    this.errorDescription,
  });

  factory BaseResult.fromJson(String str) =>
      BaseResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory BaseResult.fromMap(Map<String, dynamic> json) => BaseResult(
        success: json["success"] == null ? null : json["success"],
        errorDescription:
            json["errorDescription"] == null ? null : json["errorDescription"],
      );

  Map<String, dynamic> toMap() => {
        "success": success == null ? null : success,
        "errorDescription": errorDescription == null ? null : errorDescription,
      };
}

class FoodAnswer {
  FoodAnswer({
    this.technicalException,
    this.information,
    this.code,
    this.success,
    this.canForceAccept,
    this.orderId,
  });

  String technicalException;
  Information information;
  String code;
  bool success;
  bool canForceAccept;
  String orderId;

  factory FoodAnswer.fromJson(String str) =>
      FoodAnswer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FoodAnswer.fromMap(Map<String, dynamic> json) => FoodAnswer(
        technicalException: json["technicalException"],
        information: Information.fromMap(json["information"]),
        code: json["code"],
        success: json["success"],
        canForceAccept: json["canForceAccept"],
        orderId: json["orderId"],
      );

  Map<String, dynamic> toMap() => {
        "technicalException": technicalException,
        "information": information.toMap(),
        "code": code,
        "success": success,
        "canForceAccept": canForceAccept,
        "orderId": orderId,
      };
}

class Information {
  Information({
    this.langValue1,
    this.langValue2,
    this.langValue3,
  });

  String langValue1;
  String langValue2;
  String langValue3;

  factory Information.fromJson(String str) =>
      Information.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Information.fromMap(Map<String, dynamic> json) => Information(
        langValue1: json["langValue1"],
        langValue2: json["langValue2"],
        langValue3: json["langValue3"],
      );

  Map<String, dynamic> toMap() => {
        "langValue1": langValue1,
        "langValue2": langValue2,
        "langValue3": langValue3,
      };
}
