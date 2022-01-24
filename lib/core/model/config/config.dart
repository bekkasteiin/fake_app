import 'dart:convert';

import 'package:hive/hive.dart';

import 'file.dart';

part 'config.g.dart';

@HiveType(typeId: 79)
class KrjConfig {
  KrjConfig({
    this.entityName,
    this.instanceName,
    this.id,
    this.code,
    this.description1,
    this.configFile,
    this.isSystemRecord,
    this.active,
    this.isDefault,
    this.langValue1,
    this.order,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String code;
  @HiveField(4)
  String description1;
  @HiveField(5)
  ConfigFile configFile;
  @HiveField(6)
  bool isSystemRecord;
  @HiveField(7)
  bool active;
  @HiveField(8)
  bool isDefault;
  @HiveField(9)
  String langValue1;
  @HiveField(10)
  int order;

  factory KrjConfig.fromJson(String str) => KrjConfig.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory KrjConfig.fromMap(Map<String, dynamic> json) => KrjConfig(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        code: json['code'],
        description1: json['description1'],
        configFile: json['configFile'] == null
            ? null
            : ConfigFile.fromMap(json['configFile']),
        isSystemRecord: json['isSystemRecord'],
        active: json['active'],
        isDefault: json['isDefault'],
        langValue1: json['langValue1'],
        order: json['order'],
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'code': code,
        'description1': description1,
        'configFile': configFile == null ? null : configFile.toMap(),
        'isSystemRecord': isSystemRecord,
        'active': active,
        'isDefault': isDefault,
        'langValue1': langValue1,
        'order': order,
      };
}
