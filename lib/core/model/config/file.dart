import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part 'file.g.dart';

@HiveType(typeId: 80)
class ConfigFile {
  ConfigFile({
    this.entityName,
    this.instanceName,
    this.id,
    this.extension,
    this.name,
    this.createDate,
  });

  @HiveField(0)
  String entityName;
  @HiveField(1)
  String instanceName;
  @HiveField(2)
  String id;
  @HiveField(3)
  String extension;
  @HiveField(4)
  String name;
  @HiveField(5)
  DateTime createDate;

  factory ConfigFile.fromJson(String str) =>
      ConfigFile.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ConfigFile.fromMap(Map<String, dynamic> json) => ConfigFile(
        entityName: json['_entityName'],
        instanceName: json['_instanceName'],
        id: json['id'],
        extension: json['extension'],
        name: json['name'],
        createDate: json['createDate'] == null
            ? null
            : DateTime.parse(json['createDate']),
      );

  Map<String, dynamic> toMap() => {
        '_entityName': entityName,
        '_instanceName': instanceName,
        'id': id,
        'extension': extension,
        'name': name,
        'createDate': createDate == null
            ? null
            : DateFormat('yyyy-MM-dd HH:mm:ss.SSS').format(createDate),
      };
}
