import 'dart:convert';

import 'package:hive/hive.dart';

part 'Defect.g.dart';

@HiveType(typeId: 35)
class Defect {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  String defect;
  @HiveField(3)
  String comment;

  Defect({
    this.entityName,
    this.id,
    this.defect,
    this.comment,
  });

  factory Defect.fromJson(String str) => Defect.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Defect.fromMap(Map<String, dynamic> json) => Defect(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        defect: json["defect"] == null ? null : json["defect"],
        comment: json["comment"] == null ? null : json["comment"],
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "defect": defect == null ? null : defect,
        "comment": comment == null ? null : comment,
      };
}
