
import 'dart:convert';
import 'dart:typed_data';

import 'package:hive/hive.dart';

part 'file_descriptor.g.dart';

@HiveType(typeId: 124)
class FileDescriptor {
  FileDescriptor({
    this.entityName,
    this.instanceName,
    this.id,
    this.extension,
    this.name,
    this.version,
    this.createDate,
    this.byte,
    this.localPath,
    this.fileName
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
  int version;
  @HiveField(6)
  DateTime createDate;
  @HiveField(7)
  String localPath;
  @HiveField(8)
  String fileName;
  @HiveField(9)
  Uint8List byte;

  factory FileDescriptor.fromJson(String str) => FileDescriptor.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FileDescriptor.fromMap(Map<String, dynamic> json) => FileDescriptor(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    extension: json["extension"] == null ? null : json["extension"],
    name: json["name"] == null ? null : json["name"],
    version: json["version"] == null ? null : json["version"],
    createDate: json["createDate"] == null ? null : DateTime.parse(json["createDate"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id
  };
}