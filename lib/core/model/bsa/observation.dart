import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hse/core/model/message/message_dictionary.dart';
part 'observation.g.dart';
@HiveType(typeId: 127)
class Observation {
  Observation({
    this.entityName,
    this.instanceName,
    this.id,
    this.observationKindSitutation,
    this.observationKindDanger,
    this.observationSevirityConsequences,
    this.observationCategory,
    this.comment,
    this.isChecked,
  });

  @HiveField (0)
  String entityName;
  @HiveField (1)
  String instanceName;
  @HiveField (2)
  String id;
  @HiveField (3)
  AbstractDictionary observationKindSitutation;
  @HiveField (4)
  AbstractDictionary observationKindDanger;
  @HiveField (5)
  AbstractDictionary observationSevirityConsequences;
  @HiveField (6)
  AbstractDictionary observationCategory;
  @HiveField (7)
  String comment;
  @HiveField (8)
  bool isChecked;

  factory Observation.fromMap(Map<String, dynamic> json) => Observation(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    observationKindSitutation: json["observationKindSitutation"] == null ? null : AbstractDictionary.fromMap(json["observationKindSitutation"]),
    observationKindDanger: json["observationKindDanger"] == null ? null : AbstractDictionary.fromMap(json["observationKindDanger"]),
    observationSevirityConsequences: json["observationSevirityConsequences"] == null ? null : AbstractDictionary.fromMap(json["observationSevirityConsequences"]),
    observationCategory: json["observationCategory"] == null ? null : AbstractDictionary.fromMap(json["observationCategory"]),
    comment: json["comment"] == null ? null : json["comment"],
    isChecked: json["isChecked"] == null ? false : json["isChecked"],
  );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
    //  "_entityName": entityName == null ? null : entityName,
    // "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? "" : id,
    "observationKindSitutation": observationKindSitutation == null ? null : observationKindSitutation.toMap(),
    "observationKindDanger": observationKindDanger == null ? null : observationKindDanger.toMap(),
    "observationSevirityConsequences": observationSevirityConsequences == null ? null : observationSevirityConsequences.toMap(),
    "observationCategory": observationCategory == null ? null : observationCategory.toMap(),
    "comment": comment == null ? null : comment,
    "isChecked": isChecked == null ? null : isChecked,
  };
}