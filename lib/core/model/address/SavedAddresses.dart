import 'dart:convert';

import 'package:hive/hive.dart';

part 'SavedAddresses.g.dart';

SavedAddresses savedAddressesFromJson(String str) =>
    SavedAddresses.fromMap(json.decode(str));

String savedAddressesToJson(SavedAddresses data) => json.encode(data.toMap());

@HiveType(typeId: 56)
class SavedAddresses {
  @HiveField(0)
  int id;
  @HiveField(1)
  String address;
  @HiveField(2)
  String type;

  SavedAddresses({
    this.id,
    this.address,
    this.type,
  });

  factory SavedAddresses.fromMap(Map<String, dynamic> json) {
    return SavedAddresses(
      id: json["id"],
      address: json["address"],
      type: json["type"],
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "address": address,
        "type": type,
      };
}
