

import 'dart:convert';

class CheckPersonResponse {
  CheckPersonResponse({
    this.entityName,
    this.instanceName,
    this.id,
    this.fullName,
    this.status,
  });

  String entityName;
  String instanceName;
  String id;
  String fullName;
  bool status;

  factory CheckPersonResponse.fromJson(String str) => CheckPersonResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CheckPersonResponse.fromMap(Map<String, dynamic> json) => CheckPersonResponse(
    entityName: json["_entityName"] == null ? null : json["_entityName"],
    instanceName: json["_instanceName"] == null ? null : json["_instanceName"],
    id: json["id"] == null ? null : json["id"],
    fullName: json["fullName"] == null ? null : json["fullName"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toMap() => {
    "_entityName": entityName == null ? null : entityName,
    "_instanceName": instanceName == null ? null : instanceName,
    "id": id == null ? null : id,
    "fullName": fullName == null ? null : fullName,
    "status": status == null ? null : status,
  };
}
