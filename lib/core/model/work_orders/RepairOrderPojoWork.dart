import 'dart:convert';

import 'package:hive/hive.dart';

import 'Defect.dart';
import 'Material.dart';
import 'Person.dart';

part 'RepairOrderPojoWork.g.dart';

@HiveType(typeId: 34)
class RepairOrderPojoWork {
  @HiveField(0)
  String entityName;
  @HiveField(1)
  String id;
  @HiveField(2)
  List<Defect> defect;
  @HiveField(3)
  List<Material> material;
  @HiveField(4)
  String repairClass;
  @HiveField(5)
  List<Person> person;

  RepairOrderPojoWork({
    this.entityName,
    this.id,
    this.defect,
    this.material,
    this.repairClass,
    this.person,
  });

  factory RepairOrderPojoWork.fromJson(String str) =>
      RepairOrderPojoWork.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RepairOrderPojoWork.fromMap(Map<String, dynamic> json) =>
      RepairOrderPojoWork(
        entityName: json["_entityName"] == null ? null : json["_entityName"],
        id: json["id"] == null ? null : json["id"],
        defect: json["defect"] == null
            ? []
            : List<Defect>.from(json["defect"].map((x) => Defect.fromMap(x))),
        material: json["material"] == null
            ? []
            : List<Material>.from(
                json["material"].map((x) => Material.fromMap(x))),
        repairClass: json["repairClass"] == null ? null : json["repairClass"],
        person: json["person"] == null
            ? []
            : List<Person>.from(json["person"].map((x) => Person.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "_entityName": entityName == null ? null : entityName,
        "id": id == null ? null : id,
        "defect": defect == null
            ? []
            : List<dynamic>.from(defect.map((x) => x.toMap())),
        "material": material == null
            ? []
            : List<dynamic>.from(material.map((x) => x.toMap())),
        "repairClass": repairClass == null ? null : repairClass,
        "person": person == null
            ? []
            : List<dynamic>.from(person.map((x) => x.toMap())),
      };
}
